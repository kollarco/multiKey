// multikey_loader.js
// Sample-pool, zones and per-sound settings manager for the multiKey Max for Live device.
//
// Runs in the low-priority (UI) thread, which is fine: it only handles loading,
// settings and saving. The time-critical note path (zone choice, random pick, chord
// dealing, voice allocation) is native Max objects in the main patcher; this script
// feeds it lookup tables ([coll]s) and urn ranges.
//
// CRASH SAFETY (v0.7): buffers in the polybuffer~ are never freed while you work.
// New sounds are appended; removed sounds just stop being referenced ("orphans").
// Freeing buffers that a playing voice or the waveform display still reads from was
// the likely cause of crashes when dropping many files. The pool is only rebuilt
// compactly when a saved set is restored on load. Several dropped files are also
// batched into one load instead of one full reload per file.
//
// Each sound has its own buffer index (`buf`). The note path finds it through a
// slot map: key = zone*1000 + position-in-zone  ->  buffer index.
//
// Inlet 0 messages:
//   droptype <type> / drop <path>   file or folder dropped on the waveform (batched)
//   loadfolderpath <path>           folder chosen with the Load folder dialog
//   addfile                         file dialog, adds one sample to the current zone
//   clear                           clear the current zone (Zones on) or everything (off)
//   removesel                       remove only the selected sound
//   select <i>                      sound chosen in the menu (index into the visible list)
//   soundvol <dB> / soundtrn <st>   settings of the selected sound
//   zones <0|1>                     Zones off / on
//   zone <0|1|2>                    zone shown in the list and targeted by loading
//   xfade <semitones>               zone crossfade width
//   preview                         play the selected sound once, at its original pitch
//   solo <0|1>                      every note plays the selected sound
//   restore <data..>                saved state from [pattr]
//   init                            re-send everything (on device load)
//
// Outlets:
//   0: count <n>                    total number of samples (gates note-ons)
//   1: umenu                        clear / append <name> / set <i>
//   2: pattr                        3 path zone dB st ...  (echo is ignored by restore)
//   3: per-sound coll               clear / <buffer index> <gain> <semitones>
//   4: waveform~                    set <buffer name>   (blank buffer when nothing is selected)
//   5: UI                           name|vol|trn|label set ... / tp <thispatcher message>
//                                   solo <buffer index or 0> / solobtn set <0|1> / preview midinote ...
//   6: zone ranges                  c0 c1 c2 total key0 key1 key2 keyAll
//   7: zone table coll              clear / <pitch> <zone> <neighbour> <probability>
//   8: slot map coll                clear / <zone*1000 + i> <buffer index>

autowatch = 1;
inlets = 1;
outlets = 9;

setinletassist(0, "commands");
setoutletassist(0, "count <n>");
setoutletassist(1, "to umenu");
setoutletassist(2, "to pattr (storage)");
setoutletassist(3, "to per-sound coll");
setoutletassist(4, "to waveform~");
setoutletassist(5, "to UI router");
setoutletassist(6, "zone counts / slot keys");
setoutletassist(7, "to zone table coll");
setoutletassist(8, "to slot map coll");

var POOL = (jsarguments.length > 1) ? String(jsarguments[1]) : "mkpool";
var EMPTY = (jsarguments.length > 2) ? String(jsarguments[2]) : "mkempty";   // blank buffer for the waveform
var FORMAT = 3;                   // stored as: 3 path zone dB st ...  (number first = a plain list)
var ZONE_NAMES = ["Low", "Mid", "High"];
var ZONE_OCTAVE = [12, 0, -12];   // Low an octave up (bass samples are recorded low), High an octave down
var BORDER1 = 47.5;               // between B1 (47) and C2 (48)
var BORDER2 = 71.5;               // between B3 (71) and C4 (72)
var AUDIO_RE = /\.(wav|wave|aif|aiff|flac|mp3|m4a|ogg|caf)$/i;
var DROP_BATCH_MS = 150;          // collect every file of one drag before loading

// keyboard picture on the Zones tab: C0 (24) .. C6 (96) across 400 px
var KB_X = 256, KB_W = 400, KB_LO = 24, KB_HI = 96, XF_Y = 96, XF_H = 34;

var pb = null;
var dropType = "";
var pendingDrops = [];
var dropTask = null;
var lastStored = null;
var sounds = [];                  // [{path, zone, vol, trn, buf}], display order: by zone
var sel = null;                   // selected sound object (or null)
var ready = false;
var zonesOn = false;
var currentZone = 1;
var xfadeSt = 0;
var soloOn = false;
var previewTask = null;
var PREVIEW_PITCH = 0;            // C-2: lowest MIDI note, practically never played

function pool() {
    if (pb === null) {
        pb = new PolyBuffer(POOL);
    }
    return pb;
}

function basename(path) {
    return String(path).replace(/^.*[\/:]/, "").replace(/\.[^.]+$/, "");
}

function clamp(v, lo, hi) {
    return Math.max(lo, Math.min(hi, v));
}

// Raw rows of the polybuffer: [index, name, path, duration, channels, sr]
function poolRows() {
    var rows = [];
    var d;
    try {
        d = pool().dump();
    } catch (e) {
        return rows;
    }
    if (!d || !d.length) {
        return rows;
    }
    var i;
    if (d[0] instanceof Array) {
        return d;
    }
    for (i = 0; i + 5 < d.length; i += 6) {
        rows.push(d.slice(i, i + 6));
    }
    return rows;
}

function poolCount() {
    var c = pool().count;
    return (typeof c === "number") ? c : poolRows().length;
}

// Append one file; returns its buffer index (1-based) or -1.
function appendBuf(path) {
    var before = poolCount();
    try {
        pool().append(path);
    } catch (e) {
        post("multiKey: could not load " + path + "\n");
        return -1;
    }
    var after = poolCount();
    if (after > before) {
        return after;
    }
    post("multiKey: could not load " + path + "\n");
    return -1;
}

function durationOfBuf(buf) {
    var rows = poolRows();
    var r = rows[buf - 1];
    return r ? (Number(r[3]) || 2000) : 2000;
}

function sortByZone() {
    var i;
    for (i = 0; i < sounds.length; i++) {
        sounds[i]._n = i;                 // stable: keep load order within a zone
    }
    sounds.sort(function (a, b) {
        return (a.zone - b.zone) || (a._n - b._n);
    });
}

// Sounds shown in the menu.
function visible() {
    var out = [];
    var i;
    for (i = 0; i < sounds.length; i++) {
        if (!zonesOn || sounds[i].zone === currentZone) {
            out.push(sounds[i]);
        }
    }
    return out;
}

function inZone(z) {
    var out = [];
    var i;
    for (i = 0; i < sounds.length; i++) {
        if (sounds[i].zone === z) {
            out.push(sounds[i]);
        }
    }
    return out;
}

function counts() {
    return [inZone(0).length, inZone(1).length, inZone(2).length];
}

function folderFiles(path) {
    var files = [];
    var f;
    try {
        f = new Folder(path);
    } catch (e) {
        post("multiKey: cannot open folder " + path + "\n");
        return files;
    }
    var base = String(path);
    if (!/[\/:]$/.test(base)) {
        base += "/";
    }
    while (!f.end) {
        var name = String(f.filename);
        if (AUDIO_RE.test(name)) {
            files.push(base + name);
        }
        f.next();
    }
    f.close();
    files.sort(function (a, b) {
        var x = a.toLowerCase(), y = b.toLowerCase();
        return x < y ? -1 : (x > y ? 1 : 0);
    });
    return files;
}

// ---------- outputs ----------

function store() {
    var data = [FORMAT];
    var i;
    for (i = 0; i < sounds.length; i++) {
        data.push(sounds[i].path, sounds[i].zone, sounds[i].vol, sounds[i].trn);
    }
    // Send as a normal value (not "set"): Live only saves a parameter it sees change.
    // pattr echoes it back to restore(), which ignores it via lastStored.
    lastStored = data.join("|");
    outlet(2, data);
}

function sendCollRow(s) {
    var semis = s.trn + (zonesOn ? ZONE_OCTAVE[s.zone] : 0);
    outlet(3, s.buf, Math.pow(10, s.vol / 20), semis);
}

function sendZoneRanges() {
    var c = counts();
    outlet(6, c[0], c[1], c[2], sounds.length, 0, 1000, 2000, 3000);
}

function sendSlotMap() {
    var z, i, list;
    outlet(8, "clear");
    for (z = 0; z < 3; z++) {
        list = inZone(z);
        for (i = 0; i < list.length; i++) {
            outlet(8, z * 1000 + i, list[i].buf);
        }
    }
    for (i = 0; i < sounds.length; i++) {
        outlet(8, 3000 + i, sounds[i].buf);        // "all sounds" (Zones off)
    }
}

// For every MIDI pitch: own zone, neighbour zone, chance of picking the neighbour.
// Zone 3 = "all sounds" (Zones off). 50/50 at a border, falling linearly to 0 at
// `xfade` semitones from it; beyond that only the own zone plays.
function zoneRow(p, c) {
    var zp, nb, d, prob;
    if (!zonesOn) {
        return [3, 3, 0];
    }
    zp = p >= 72 ? 2 : (p >= 48 ? 1 : 0);
    if (zp === 0) {
        d = BORDER1 - p; nb = 1;
    } else if (zp === 2) {
        d = p - BORDER2; nb = 1;
    } else if (p - BORDER1 <= BORDER2 - p) {
        d = p - BORDER1; nb = 0;
    } else {
        d = BORDER2 - p; nb = 2;
    }
    prob = xfadeSt > 0 ? Math.max(0, 0.5 * (1 - d / xfadeSt)) : 0;

    // empty zones: borrow from the nearest zone that has sounds
    if (c[zp] === 0) {
        if (c[nb] > 0) {
            zp = nb;
        } else {
            var order = zp === 1 ? [0, 2] : (zp === 0 ? [1, 2] : [1, 0]);
            zp = c[order[0]] > 0 ? order[0] : (c[order[1]] > 0 ? order[1] : 3);
        }
        nb = zp;
        prob = 0;
    } else if (c[nb] === 0) {
        nb = zp;
        prob = 0;
    }
    return [zp, nb, prob];
}

function sendZoneTable() {
    var c = counts();
    var p;
    outlet(7, "clear");
    for (p = 0; p < 128; p++) {
        outlet(7, [p].concat(zoneRow(p, c)));
    }
}

function kbx(pitch) {
    return KB_X + (pitch - KB_LO) * KB_W / (KB_HI - KB_LO);
}

function sendZoneVisual() {
    var w = Math.max(1, 2 * xfadeSt * KB_W / (KB_HI - KB_LO));
    outlet(5, "tp", "script", "sendbox", "zxf1", "presentation_rect",
           kbx(BORDER1) - w / 2, XF_Y, w, XF_H);
    outlet(5, "tp", "script", "sendbox", "zxf2", "presentation_rect",
           kbx(BORDER2) - w / 2, XF_Y, w, XF_H);
    outlet(5, "tp", "script", zonesOn ? "show" : "hide", "zonesel");
}

function sendSolo() {
    outlet(5, "solo", (soloOn && sel) ? sel.buf : 0);
    outlet(5, "solobtn", "set", soloOn ? 1 : 0);
}

function sendSoundUI() {
    if (!sel) {
        outlet(5, "name", "set", "No sound selected");
        outlet(5, "vol", "set", 0);
        outlet(5, "trn", "set", 0);
        return;
    }
    var pos = visible().indexOf(sel) + 1;
    outlet(5, "name", "set", (zonesOn ? ZONE_NAMES[sel.zone] + " " : "") + pos + ": " + basename(sel.path));
    outlet(5, "vol", "set", sel.vol);
    outlet(5, "trn", "set", sel.trn);
}

function sendLabel() {
    var solo = soloOn ? "SOLO / " : "";
    var c = counts();
    if (zonesOn) {
        outlet(5, "label", "set", solo + "L " + c[0] + " / M " + c[1] + " / H " + c[2]);
    } else if (sounds.length === 0) {
        outlet(5, "label", "set", "drop a folder on the waveform");
    } else {
        outlet(5, "label", "set", solo + sounds.length + " samples");
    }
}

function showWaveform() {
    outlet(4, "set", sel ? POOL + "." + sel.buf : EMPTY);
}

function showMenu() {
    var vis = visible();
    var i;
    outlet(1, "clear");
    for (i = 0; i < vis.length; i++) {
        outlet(1, "append", (i + 1) + ": " + basename(vis[i].path));
    }
    if (vis.length === 0) {
        outlet(1, "append", zonesOn ? "(" + ZONE_NAMES[currentZone] + " zone empty)"
                                    : "(no samples - drop a folder)");
    }
    if (vis.indexOf(sel) === -1) {        // keep the selection inside the visible list
        sel = vis.length > 0 ? vis[0] : null;
    }
    if (sel) {
        outlet(1, "set", vis.indexOf(sel));
    }
    showWaveform();
    sendSoundUI();
    sendSolo();
}

// Push everything to the patcher. Call after any change to sounds/zones.
function refresh(doStore) {
    var i;
    sortByZone();
    outlet(3, "clear");
    for (i = 0; i < sounds.length; i++) {
        sendCollRow(sounds[i]);
    }
    sendSlotMap();
    sendZoneRanges();
    sendZoneTable();
    showMenu();
    sendLabel();
    sendZoneVisual();
    if (doStore) {
        store();
    }
    outlet(0, "count", sounds.length);
}

function newSounds(files, zone) {
    var out = [];
    var i, buf;
    for (i = 0; i < files.length; i++) {
        buf = appendBuf(files[i]);
        if (buf > 0) {
            out.push({ path: files[i], zone: zone, vol: 0, trn: 0, buf: buf });
        }
    }
    return out;
}

// Replace the current zone (Zones on) or everything (Zones off) with these files.
// Old buffers are left in the pool, unreferenced (freeing them could crash a voice).
function replaceWith(files) {
    var kept = [];
    var i;
    if (zonesOn) {
        for (i = 0; i < sounds.length; i++) {
            if (sounds[i].zone !== currentZone) {
                kept.push(sounds[i]);
            }
        }
    }
    var added = newSounds(files, currentZone);
    sounds = kept.concat(added);
    sel = added.length ? added[0] : null;
    refresh(true);
}

function addFiles(files) {
    var added = newSounds(files, currentZone);
    sounds = sounds.concat(added);
    if (added.length) {
        sel = added[added.length - 1];
    }
    refresh(true);
}

// ---------- messages ----------

function droptype(t) {
    dropType = String(t);
}

function drop() {
    var path = arrayfromargs(arguments).join(" ");
    pendingDrops.push({ path: path, folder: (dropType === "fold") || /[\/:]$/.test(path) });
    dropType = "";
    if (dropTask === null) {
        dropTask = new Task(processDrops, this);
    }
    dropTask.cancel();
    dropTask.schedule(DROP_BATCH_MS);
}

// One load for everything dropped in one drag. A folder in the drop replaces the
// zone; loose files only are added.
function processDrops() {
    var items = pendingDrops;
    pendingDrops = [];
    var files = [];
    var anyFolder = false;
    var i;
    for (i = 0; i < items.length; i++) {
        if (items[i].folder) {
            anyFolder = true;
            files = files.concat(folderFiles(items[i].path));
        } else if (AUDIO_RE.test(items[i].path)) {
            files.push(items[i].path);
        }
    }
    if (anyFolder) {
        replaceWith(files);
    } else if (files.length) {
        addFiles(files);
    }
}

function loadfolderpath() {
    replaceWith(folderFiles(arrayfromargs(arguments).join(" ")));
}

function addfile() {
    var before = poolCount();
    pool().append();                      // no argument -> file dialog
    var after = poolCount();
    if (after > before) {
        var row = poolRows()[after - 1];
        var s = { path: row ? String(row[2]) : "", zone: currentZone, vol: 0, trn: 0, buf: after };
        sounds.push(s);
        sel = s;
        refresh(true);
    }
}

function clear() {
    if (zonesOn) {
        replaceWith([]);
    } else {
        sounds = [];
        sel = null;
        refresh(true);
    }
}

// Remove only the sound selected in the menu. Like clear(), the buffer stays in the
// pool (unreferenced): freeing it could crash a voice that is still playing it.
// The selection moves to the sound that takes its place in the list (or the one
// before it when the last one was removed).
function removesel() {
    if (!sel) {
        post("multiKey: remove - no sound selected\n");
        return;
    }
    var vis = visible();
    var pos = vis.indexOf(sel);
    var idx = sounds.indexOf(sel);
    if (idx === -1) {
        return;
    }
    sounds.splice(idx, 1);
    vis = visible();
    sel = vis.length > 0 ? vis[Math.min(Math.max(pos, 0), vis.length - 1)] : null;
    refresh(true);
}

function select(i) {
    var vis = visible();
    i = Math.floor(i);
    if (i < 0 || i >= vis.length) {
        return;
    }
    sel = vis[i];
    showWaveform();
    sendSoundUI();
    sendSolo();
}

function stopPreview() {
    outlet(5, "preview", "midinote", PREVIEW_PITCH, 0, 0, 0, 0, 0, 0);
}

function preview() {
    if (!sel) {
        post("multiKey: preview - no sound selected\n");
        return;
    }
    if (previewTask !== null) {
        previewTask.cancel();
        stopPreview();
    }
    // original pitch + this sound's own Transpose and Volume (no zone octave, no velocity)
    outlet(5, "preview", "midinote", PREVIEW_PITCH, 127, sel.buf, sel.trn,
           0.8 * Math.pow(10, sel.vol / 20), 0, 1);
    previewTask = new Task(stopPreview, this);
    previewTask.schedule(durationOfBuf(sel.buf));
}

function solo(v) {
    soloOn = !!v;
    sendSolo();
    sendLabel();
}

function soundvol(v) {
    if (!ready || !sel) {
        return;
    }
    sel.vol = clamp(v, -36, 12);
    sendCollRow(sel);
    store();
}

function soundtrn(v) {
    if (!ready || !sel) {
        return;
    }
    sel.trn = Math.round(clamp(v, -24, 24));
    sendCollRow(sel);
    store();
}

function zones(v) {
    zonesOn = !!v;
    refresh(false);
}

function zone(v) {
    currentZone = clamp(Math.floor(v), 0, 2);
    sel = null;
    showMenu();
}

function xfade(v) {
    xfadeSt = clamp(v, 0, 12);
    sendZoneTable();
    sendZoneVisual();
}

// Restoring a saved set: the only time the pool is cleared and rebuilt compactly.
function restore() {
    var args = arrayfromargs(arguments);
    if (String(args[0]) === "set") {
        args.shift();
    }
    if (args.join("|") === lastStored) {
        return;   // our own value echoing back from pattr
    }
    var list = [];
    var i;
    var fmt = String(args[0]);
    if (fmt === "3" || fmt === "mk3") {
        for (i = 1; i + 3 < args.length; i += 4) {
            list.push({ path: String(args[i]),
                        zone: clamp(Math.floor(Number(args[i + 1]) || 0), 0, 2),
                        vol: Number(args[i + 2]) || 0, trn: Number(args[i + 3]) || 0 });
        }
    } else if (fmt === "mk2") {
        for (i = 1; i + 2 < args.length; i += 3) {
            list.push({ path: String(args[i]), zone: 1,
                        vol: Number(args[i + 1]) || 0, trn: Number(args[i + 2]) || 0 });
        }
    } else {
        for (i = 0; i < args.length; i++) {   // v0.1-v0.3: plain list of paths
            var s = String(args[i]);
            if (s.indexOf("/") !== -1 || s.indexOf(":") !== -1) {
                list.push({ path: s, zone: 1, vol: 0, trn: 0 });
            }
        }
    }
    if (list.length === 0) {
        return;   // empty or initial value: nothing to restore, don't wipe what's loaded
    }
    outlet(4, "set", EMPTY);              // detach the waveform before buffers go away
    pool().clear();
    var keep = [];
    for (i = 0; i < list.length; i++) {
        var buf = appendBuf(list[i].path);
        if (buf > 0) {
            list[i].buf = buf;
            keep.push(list[i]);
        }
    }
    if (keep.length < list.length) {
        post("multiKey: " + (list.length - keep.length) + " saved sample(s) could not be found\n");
    }
    sounds = keep;
    sel = null;
    refresh(true);
}

function init() {
    refresh(false);
    ready = true;
}

function anything() {
    post("multiKey loader: unknown message " + messagename + "\n");
}
