// multikey_loader.js
// Sample-pool, zones and per-sound settings manager for the multiKey Max for Live device.
//
// Runs in the low-priority (UI) thread, which is fine: it only handles loading,
// settings and saving. The time-critical note path (zone choice, random pick, chord
// dealing, voice allocation) is native Max objects in the main patcher; this script
// feeds it lookup tables ([coll]s) and urn ranges.
//
// Sounds are kept in one polybuffer~, ordered by zone (Low, Mid, High), so each zone
// is a contiguous block of buffer indices: zone z = base[z] .. base[z] + count[z] - 1.
//
// Inlet 0 messages:
//   droptype <type> / drop <path>   file or folder dropped on the waveform
//   loadfolderpath <path>           folder chosen with the Load folder dialog
//   addfile                         file dialog, adds one sample to the current zone
//   clear                           clear the current zone (Zones on) or everything (off)
//   select <i>                      sound chosen in the menu (index into the visible list)
//   soundvol <dB> / soundtrn <st> / soundreset   settings of the selected sound
//   zones <0|1>                     Zones off / on
//   zone <0|1|2>                    zone shown in the list and targeted by loading
//   xfade <semitones>               zone crossfade width
//   restore <data..>                saved state from [pattr]
//   init                            re-send everything (on device load)
//
// Outlets:
//   0: count <n>                    total number of samples (gates note-ons)
//   1: umenu                        clear / append <name> / set <i>
//   2: pattr                        set mk3 path zone dB st ...
//   3: per-sound coll               clear / <index> <gain> <semitones>
//   4: waveform~                    set <buffer name>   (blank buffer when nothing is selected)
//   5: UI                           name|vol|trn|label set ... / tp <thispatcher message>
//   6: zone ranges                  c0 c1 c2 total base0 base1 base2 baseAll
//   7: zone table coll              clear / <pitch> <zone> <neighbour> <probability>

autowatch = 1;
inlets = 1;
outlets = 8;

setinletassist(0, "commands");
setoutletassist(0, "count <n>");
setoutletassist(1, "to umenu");
setoutletassist(2, "to pattr (storage)");
setoutletassist(3, "to per-sound coll");
setoutletassist(4, "to waveform~");
setoutletassist(5, "to UI router");
setoutletassist(6, "zone counts / index bases");
setoutletassist(7, "to zone table coll");

var POOL = (jsarguments.length > 1) ? String(jsarguments[1]) : "mkpool";
var EMPTY = (jsarguments.length > 2) ? String(jsarguments[2]) : "mkempty";   // blank buffer for the waveform
var FORMAT = "mk3";               // mk3 path zone dB st ...
var ZONE_NAMES = ["Low", "Mid", "High"];
var ZONE_OCTAVE = [12, 0, 0];     // Low plays an octave up: bass one-shots are usually recorded low
var BORDER1 = 47.5;               // between B1 (47) and C2 (48)
var BORDER2 = 71.5;               // between B3 (71) and C4 (72)
var AUDIO_RE = /\.(wav|wave|aif|aiff|flac|mp3|m4a|ogg|caf)$/i;

// keyboard picture on the Zones tab: C0 (24) .. C6 (96) across 400 px
var KB_X = 256, KB_W = 400, KB_LO = 24, KB_HI = 96, XF_Y = 96, XF_H = 34;

var pb = null;
var dropType = "";
var lastStored = null;
var sounds = [];                  // [{path, zone, vol, trn}], kept ordered by zone
var selected = -1;                // index into sounds (= buffer index - 1)
var ready = false;
var zonesOn = false;
var currentZone = 1;
var xfadeSt = 0;

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

function sortByZone() {
    var i;
    for (i = 0; i < sounds.length; i++) {
        sounds[i]._n = i;                 // stable: keep load order within a zone
    }
    sounds.sort(function (a, b) {
        return (a.zone - b.zone) || (a._n - b._n);
    });
}

// Indices (into sounds) shown in the menu.
function visible() {
    var out = [];
    var i;
    for (i = 0; i < sounds.length; i++) {
        if (!zonesOn || sounds[i].zone === currentZone) {
            out.push(i);
        }
    }
    return out;
}

function counts() {
    var c = [0, 0, 0];
    var i;
    for (i = 0; i < sounds.length; i++) {
        c[sounds[i].zone]++;
    }
    return c;
}

// Paths currently in the polybuffer (used after a dialog append).
function poolPaths() {
    var paths = [];
    var d;
    try {
        d = pool().dump();
    } catch (e) {
        return paths;
    }
    if (!d || !d.length) {
        return paths;
    }
    var i;
    if (d[0] instanceof Array) {
        for (i = 0; i < d.length; i++) {
            paths.push(String(d[i][2]));
        }
    } else {
        for (i = 0; i + 2 < d.length; i += 6) {
            paths.push(String(d[i + 2]));
        }
    }
    return paths;
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
    lastStored = data.join("|");
    if (sounds.length === 0) {
        outlet(2, "set", "none");
    } else {
        outlet(2, ["set"].concat(data));
    }
}

function sendCollRow(i) {
    var s = sounds[i];
    var semis = s.trn + (zonesOn ? ZONE_OCTAVE[s.zone] : 0);
    outlet(3, i + 1, Math.pow(10, s.vol / 20), semis);
}

function sendZoneRanges() {
    var c = counts();
    outlet(6, c[0], c[1], c[2], sounds.length,
           1, 1 + c[0], 1 + c[0] + c[1], 1);
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

function sendSoundUI() {
    if (selected < 0 || selected >= sounds.length) {
        outlet(5, "name", "set", "No sound selected");
        outlet(5, "vol", "set", 0);
        outlet(5, "trn", "set", 0);
        return;
    }
    var s = sounds[selected];
    var pos = visible().indexOf(selected) + 1;
    outlet(5, "name", "set", (zonesOn ? ZONE_NAMES[s.zone] + " " : "") + pos + ": " + basename(s.path));
    outlet(5, "vol", "set", s.vol);
    outlet(5, "trn", "set", s.trn);
}

function sendLabel() {
    var c = counts();
    if (zonesOn) {
        outlet(5, "label", "set", "L " + c[0] + " / M " + c[1] + " / H " + c[2]);
    } else if (sounds.length === 0) {
        outlet(5, "label", "set", "drop a folder on the waveform");
    } else {
        outlet(5, "label", "set", sounds.length + " samples");
    }
}

function showMenu() {
    var vis = visible();
    var i;
    outlet(1, "clear");
    for (i = 0; i < vis.length; i++) {
        outlet(1, "append", (i + 1) + ": " + basename(sounds[vis[i]].path));
    }
    if (vis.length === 0) {
        outlet(1, "append", zonesOn ? "(" + ZONE_NAMES[currentZone] + " zone empty)"
                                    : "(no samples - drop a folder)");
    }
    if (vis.indexOf(selected) === -1) {   // keep the selection inside the visible list
        selected = vis.length > 0 ? vis[0] : -1;
    }
    if (selected >= 0) {
        outlet(1, "set", vis.indexOf(selected));
        outlet(4, "set", POOL + "." + (selected + 1));
    } else {
        outlet(4, "set", EMPTY);             // nothing in this zone: blank waveform
    }
    sendSoundUI();
}

// Push everything to the patcher. Call after any change to sounds/zones.
function refresh(doStore) {
    var i;
    outlet(3, "clear");
    for (i = 0; i < sounds.length; i++) {
        sendCollRow(i);
    }
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

// Reload the polybuffer from `sounds`, ordered by zone.
function rebuild(selectPath) {
    sortByZone();
    pool().clear();
    var i;
    var keep = [];
    for (i = 0; i < sounds.length; i++) {
        try {
            pool().append(sounds[i].path);
            keep.push(sounds[i]);
        } catch (e) {
            post("multiKey: could not load " + sounds[i].path + "\n");
        }
    }
    sounds = keep;
    selected = -1;
    if (selectPath) {
        for (i = 0; i < sounds.length; i++) {
            if (sounds[i].path === selectPath) {
                selected = i;
                break;
            }
        }
    }
    refresh(true);
}

// Replace the current zone (Zones on) or everything (Zones off) with these files.
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
    for (i = 0; i < files.length; i++) {
        kept.push({ path: files[i], zone: currentZone, vol: 0, trn: 0 });
    }
    sounds = kept;
    rebuild(files.length ? files[0] : null);
}

function addFiles(files) {
    var i;
    for (i = 0; i < files.length; i++) {
        sounds.push({ path: files[i], zone: currentZone, vol: 0, trn: 0 });
    }
    rebuild(files.length ? files[files.length - 1] : null);
}

// ---------- messages ----------

function droptype(t) {
    dropType = String(t);
}

function drop() {
    var path = arrayfromargs(arguments).join(" ");
    var isFolder = (dropType === "fold") || /[\/:]$/.test(path);
    dropType = "";
    if (isFolder) {
        replaceWith(folderFiles(path));
    } else {
        addFiles([path]);
    }
}

function loadfolderpath() {
    replaceWith(folderFiles(arrayfromargs(arguments).join(" ")));
}

function addfile() {
    var before = poolPaths().length;
    pool().append();                      // no argument -> file dialog
    var paths = poolPaths();
    if (paths.length > before) {
        addFiles([paths[paths.length - 1]]);
    }
}

function clear() {
    if (zonesOn) {
        replaceWith([]);
    } else {
        sounds = [];
        rebuild(null);
    }
}

function select(i) {
    var vis = visible();
    i = Math.floor(i);
    if (i < 0 || i >= vis.length) {
        return;
    }
    selected = vis[i];
    outlet(4, "set", POOL + "." + (selected + 1));
    sendSoundUI();
}

function soundvol(v) {
    if (!ready || selected < 0 || selected >= sounds.length) {
        return;
    }
    sounds[selected].vol = clamp(v, -36, 12);
    sendCollRow(selected);
    store();
}

function soundtrn(v) {
    if (!ready || selected < 0 || selected >= sounds.length) {
        return;
    }
    sounds[selected].trn = Math.round(clamp(v, -24, 24));
    sendCollRow(selected);
    store();
}

function soundreset() {
    if (selected < 0 || selected >= sounds.length) {
        return;
    }
    sounds[selected].vol = 0;
    sounds[selected].trn = 0;
    sendCollRow(selected);
    sendSoundUI();
    store();
}

function zones(v) {
    zonesOn = !!v;
    refresh(false);
}

function zone(v) {
    currentZone = clamp(Math.floor(v), 0, 2);
    selected = -1;
    showMenu();
}

function xfade(v) {
    xfadeSt = clamp(v, 0, 12);
    sendZoneTable();
    sendZoneVisual();
}

function restore() {
    var args = arrayfromargs(arguments);
    if (args.join("|") === lastStored) {
        return;   // our own "set" echoing back from pattr
    }
    var list = [];
    var i;
    var fmt = String(args[0]);
    if (fmt === "mk3") {
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
    sounds = list;
    rebuild(null);
}

function init() {
    refresh(false);
    ready = true;
}

function anything() {
    post("multiKey loader: unknown message " + messagename + "\n");
}
