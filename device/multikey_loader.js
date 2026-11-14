// multikey_loader.js
// Sample-pool manager for the multiKey Max for Live device.
//
// Runs in the low-priority (UI) thread, which is fine: it only handles
// loading/clearing samples and saving the sample list with the Live set.
// The time-critical note path (random pick, chord dealing, voice allocation)
// is built from native Max objects in the main patcher.
//
// Inlet 0 messages:
//   droptype <type>    type reported by [dropfile] (arrives before the path)
//   drop <path>        a file or folder was dropped on the device
//   loadfolder         open a folder dialog, replace the pool with its samples
//   addfile            open a file dialog, add one sample to the pool
//   clear              remove all samples
//   restore <paths..>  re-load a saved sample list (from [pattr])
//   init               re-send count + menu (on device load)
//
// Outlets:
//   0: count <n>               number of samples in the pool
//   1: umenu messages          clear / append <name>
//   2: set <paths..>           storage, to [pattr mkfiles] (saved in the Live set)

autowatch = 1;
inlets = 1;
outlets = 3;

setinletassist(0, "commands: drop, loadfolder, addfile, clear, restore, init");
setoutletassist(0, "count <n>");
setoutletassist(1, "to umenu");
setoutletassist(2, "to pattr (storage)");

var POOL = (jsarguments.length > 1) ? String(jsarguments[1]) : "mkpool";
var pb = null;
var dropType = "";
var lastStored = null;

function pool() {
    if (pb === null) {
        pb = new PolyBuffer(POOL);
    }
    return pb;
}

function basename(path) {
    return String(path).replace(/^.*[\/:]/, "").replace(/\.[^.]+$/, "");
}

// Normalise PolyBuffer.dump() output into [{path: ...}, ...].
// The docs describe rows of [index, name, path, duration, channels, sr];
// handle both a nested array and a flat array, just in case.
function readPool() {
    var rows = [];
    var d;
    try {
        d = pool().dump();
    } catch (e) {
        post("multiKey: could not read pool: " + e + "\n");
        return rows;
    }
    if (!d || !d.length) {
        return rows;
    }
    var i;
    if (d[0] instanceof Array) {
        for (i = 0; i < d.length; i++) {
            rows.push({ path: String(d[i][2]) });
        }
    } else {
        for (i = 0; i + 2 < d.length; i += 6) {
            rows.push({ path: String(d[i + 2]) });
        }
    }
    return rows;
}

function store(paths) {
    var key = paths.join("|");
    lastStored = key;
    if (paths.length === 0) {
        outlet(2, "set", "none");
    } else {
        outlet(2, ["set"].concat(paths));
    }
}

function refresh(doStore) {
    var rows = readPool();
    var paths = [];
    var i;

    outlet(1, "clear");
    for (i = 0; i < rows.length; i++) {
        paths.push(rows[i].path);
        outlet(1, "append", (i + 1) + ": " + basename(rows[i].path));
    }
    if (rows.length === 0) {
        outlet(1, "append", "(no samples - drop a folder)");
    }
    if (doStore) {
        store(paths);
    }
    outlet(0, "count", rows.length);
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
    } else {
        pool().append(path);       // adds one sample
    }
    refresh(true);
}

function loadfolder() {
    pool().readfolder();   // no argument -> folder dialog
    refresh(true);
}

function addfile() {
    pool().append();       // no argument -> file dialog
    refresh(true);
}

function clear() {
    pool().clear();
    refresh(true);
}

function restore() {
    var args = arrayfromargs(arguments);
    var paths = [];
    var i;
    for (i = 0; i < args.length; i++) {
        var s = String(args[i]);
        if (s.indexOf("/") !== -1 || s.indexOf(":") !== -1) {
            paths.push(s);
        }
    }
    // Our own "set" can echo back from pattr; ignore it.
    if (paths.join("|") === lastStored) {
        return;
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
    refresh(true);
}

function init() {
    refresh(false);
}

function anything() {
    post("multiKey loader: unknown message " + messagename + "\n");
}
