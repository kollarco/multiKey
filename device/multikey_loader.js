// multikey_loader.js
// Sample-pool + per-sound settings manager for the multiKey Max for Live device.
//
// Runs in the low-priority (UI) thread, which is fine: it only handles loading,
// per-sound settings and saving. The time-critical note path (random pick, chord
// dealing, voice allocation) is native Max objects in the main patcher; per-sound
// settings reach it through a [coll] this script fills.
//
// Inlet 0 messages:
//   droptype <type>    type reported by [dropfile] (arrives before the path)
//   drop <path>        a file or folder was dropped on the device
//   loadfolder         open a folder dialog, replace the pool with its samples
//   addfile            open a file dialog, add one sample to the pool
//   clear              remove all samples
//   select <i>         sound chosen in the menu (0-based)
//   soundvol <dB>      volume of the selected sound
//   soundtrn <st>      transpose of the selected sound
//   soundreset         reset the selected sound to 0 dB / 0 st
//   restore <data..>   re-load saved state (from [pattr])
//   init               re-send everything (on device load)
//
// Outlets:
//   0: count <n>                    number of samples in the pool
//   1: umenu messages               clear / append <name> / set <i>
//   2: set <data..>                 storage, to [pattr mkfiles] (saved in the Live set)
//   3: coll messages                clear / <index> <gain> <semitones>   (1-based index)
//   4: waveform~ messages           set <buffer name>
//   5: sound-tab UI                 name set <text> / vol set <dB> / trn set <st>

autowatch = 1;
inlets = 1;
outlets = 6;

setinletassist(0, "commands");
setoutletassist(0, "count <n>");
setoutletassist(1, "to umenu");
setoutletassist(2, "to pattr (storage)");
setoutletassist(3, "to coll (per-sound gain/transpose)");
setoutletassist(4, "to waveform~");
setoutletassist(5, "to sound-tab UI");

var POOL = (jsarguments.length > 1) ? String(jsarguments[1]) : "mkpool";
var FORMAT = "mk2";       // storage format marker: mk2 path dB st path dB st ...

var pb = null;
var dropType = "";
var lastStored = null;
var sounds = [];          // [{path, vol (dB), trn (st)}]
var settingsByPath = {};  // remembers per-sound settings across reloads
var selected = -1;
var ready = false;        // ignore dial output until the device is initialised

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

// Paths of the buffers in the pool, in order. PolyBuffer.dump() rows are
// [index, name, path, duration, channels, sr]; handle nested or flat arrays.
function readPaths() {
    var paths = [];
    var d;
    try {
        d = pool().dump();
    } catch (e) {
        post("multiKey: could not read pool: " + e + "\n");
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

function store() {
    var data = [FORMAT];
    var i;
    for (i = 0; i < sounds.length; i++) {
        data.push(sounds[i].path, sounds[i].vol, sounds[i].trn);
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
    outlet(3, i + 1, Math.pow(10, s.vol / 20), s.trn);
}

function sendSoundUI() {
    if (selected < 0 || selected >= sounds.length) {
        outlet(5, "name", "set", "No sound selected");
        outlet(5, "vol", "set", 0);
        outlet(5, "trn", "set", 0);
        return;
    }
    var s = sounds[selected];
    outlet(5, "name", "set", (selected + 1) + ": " + basename(s.path));
    outlet(5, "vol", "set", s.vol);
    outlet(5, "trn", "set", s.trn);
}

function showSelected() {
    if (selected >= 0 && selected < sounds.length) {
        outlet(4, "set", POOL + "." + (selected + 1));
        outlet(1, "set", selected);
    }
    sendSoundUI();
}

// Rebuild everything from the pool's current contents.
function refresh(doStore) {
    var paths = readPaths();
    var i;

    sounds = [];
    for (i = 0; i < paths.length; i++) {
        var prev = settingsByPath[paths[i]];
        sounds.push({
            path: paths[i],
            vol: prev ? prev.vol : 0,
            trn: prev ? prev.trn : 0
        });
    }

    outlet(1, "clear");
    for (i = 0; i < sounds.length; i++) {
        outlet(1, "append", (i + 1) + ": " + basename(sounds[i].path));
    }
    if (sounds.length === 0) {
        outlet(1, "append", "(no samples - drop a folder)");
    }

    outlet(3, "clear");
    for (i = 0; i < sounds.length; i++) {
        sendCollRow(i);
    }

    if (selected >= sounds.length || selected < 0) {
        selected = sounds.length > 0 ? 0 : -1;
    }
    showSelected();

    if (doStore) {
        store();
    }
    outlet(0, "count", sounds.length);
}

function remember(i) {
    settingsByPath[sounds[i].path] = { vol: sounds[i].vol, trn: sounds[i].trn };
}

function droptype(t) {
    dropType = String(t);
}

function drop() {
    var path = arrayfromargs(arguments).join(" ");
    var isFolder = (dropType === "fold") || /[\/:]$/.test(path);
    dropType = "";
    if (isFolder) {
        pool().readfolder(path);   // replaces the whole pool
        selected = 0;
    } else {
        pool().append(path);       // adds one sample
        selected = readPaths().length - 1;
    }
    refresh(true);
}

function loadfolder() {
    pool().readfolder();   // no argument -> folder dialog
    selected = 0;
    refresh(true);
}

function addfile() {
    pool().append();       // no argument -> file dialog
    selected = readPaths().length - 1;
    refresh(true);
}

function clear() {
    pool().clear();
    selected = -1;
    refresh(true);
}

function select(i) {
    i = Math.floor(i);
    if (i < 0 || i >= sounds.length) {
        return;
    }
    selected = i;
    outlet(4, "set", POOL + "." + (selected + 1));
    sendSoundUI();
}

function soundvol(v) {
    if (!ready || selected < 0 || selected >= sounds.length) {
        return;
    }
    sounds[selected].vol = clamp(v, -36, 12);
    remember(selected);
    sendCollRow(selected);
    store();
}

function soundtrn(v) {
    if (!ready || selected < 0 || selected >= sounds.length) {
        return;
    }
    sounds[selected].trn = Math.round(clamp(v, -24, 24));
    remember(selected);
    sendCollRow(selected);
    store();
}

function soundreset() {
    if (selected < 0 || selected >= sounds.length) {
        return;
    }
    sounds[selected].vol = 0;
    sounds[selected].trn = 0;
    remember(selected);
    sendCollRow(selected);
    sendSoundUI();
    store();
}

function restore() {
    var args = arrayfromargs(arguments);
    if (args.join("|") === lastStored) {
        return;   // our own "set" echoing back from pattr
    }
    var paths = [];
    var i;
    if (String(args[0]) === FORMAT) {
        for (i = 1; i + 2 < args.length; i += 3) {
            var p = String(args[i]);
            paths.push(p);
            settingsByPath[p] = { vol: Number(args[i + 1]) || 0, trn: Number(args[i + 2]) || 0 };
        }
    } else {
        // v0.1-v0.3 format: plain list of paths
        for (i = 0; i < args.length; i++) {
            var s = String(args[i]);
            if (s.indexOf("/") !== -1 || s.indexOf(":") !== -1) {
                paths.push(s);
            }
        }
    }
    pool().clear();
    var missing = 0;
    for (i = 0; i < paths.length; i++) {
        try {
            pool().append(paths[i]);
        } catch (e) {
            missing++;
        }
    }
    if (missing > 0) {
        post("multiKey: " + missing + " saved sample(s) could not be found\n");
    }
    selected = paths.length > 0 ? 0 : -1;
    refresh(true);
}

function init() {
    refresh(false);
    ready = true;
}

function anything() {
    post("multiKey loader: unknown message " + messagename + "\n");
}
