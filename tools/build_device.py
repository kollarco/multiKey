#!/usr/bin/env python3
"""
Generate the multiKey Max for Live device from code.

Outputs (in ../device):
  multiKey.amxd           the instrument you load in Live
  multiKey.maxpat         the same main patcher as plain JSON (readable diff / fallback)
  multikey.voice.maxpat   the per-voice patcher loaded by [poly~]

The JS sample loader (device/multikey_loader.js) is hand-written, not generated.

Why generate patchers from Python? Max patch files are big JSON blobs that are
hard to review in git. Keeping the wiring here makes every change readable.
Once the design settles we may switch to editing in Max directly.

Usage:  python3 tools/build_device.py
"""
import json
import os
import struct

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.normpath(os.path.join(HERE, "..", "device"))

POOL = "---mkpool"          # '---' is replaced by a per-device-instance id in Live
VOICES = 32
DEVICE_WIDTH = 650


class Patcher:
    def __init__(self):
        self.boxes = []
        self.lines = []
        self._n = 0
        self._col = 0
        self._row = 0

    def _id(self):
        self._n += 1
        return "obj-%d" % self._n

    def _auto_rect(self, w=120, h=22):
        x = 20 + self._col * 170
        y = 20 + self._row * 34
        self._row += 1
        if self._row > 22:
            self._row = 0
            self._col += 1
        return [x, y, w, h]

    def add(self, maxclass, rect=None, pres=None, **attrs):
        oid = self._id()
        box = {"id": oid, "maxclass": maxclass}
        box["patching_rect"] = rect or self._auto_rect()
        if pres is not None:
            box["presentation"] = 1
            box["presentation_rect"] = pres
        box.update(attrs)
        self.boxes.append({"box": box})
        return oid

    def obj(self, text, ins, outs, outtypes=None, rect=None, **attrs):
        if outtypes is None:
            outtypes = [""] * outs
        return self.add("newobj", rect=rect, text=text, numinlets=ins,
                        numoutlets=outs, outlettype=outtypes, **attrs)

    def msg(self, text, rect=None, **attrs):
        return self.add("message", rect=rect, text=text, numinlets=2,
                        numoutlets=1, outlettype=[""], **attrs)

    def comment(self, text, rect=None, pres=None, **attrs):
        return self.add("comment", rect=rect, pres=pres, text=text,
                        numinlets=1, numoutlets=0, **attrs)

    def wire(self, src, outlet, dst, inlet=0):
        self.lines.append({"patchline": {"source": [src, outlet],
                                         "destination": [dst, inlet]}})

    def to_json(self, extra=None):
        p = {
            "fileversion": 1,
            "appversion": {"major": 9, "minor": 0, "revision": 7,
                           "architecture": "x64", "modernui": 1},
            "classnamespace": "box",
            "rect": [100.0, 100.0, 1200.0, 800.0],
            "default_fontsize": 10.0,
            "default_fontface": 0,
            "default_fontname": "Arial",
            "gridonopen": 1,
            "gridsize": [15.0, 15.0],
            "boxes": self.boxes,
            "lines": self.lines,
        }
        if extra:
            p.update(extra)
        return {"patcher": p}


def live_param(longname, ptype, mmin=0.0, mmax=1.0, initial=0.0, unit=1,
               exponent=None, enum=None, shortname=None, invisible=None, steps=None):
    v = {
        "parameter_longname": longname,
        "parameter_shortname": shortname or longname,
        "parameter_type": ptype,          # 0 float, 1 int, 2 enum, 3 blob
        "parameter_mmin": mmin,
        "parameter_mmax": mmax,
        "parameter_initial": [initial],
        "parameter_initial_enable": 1,
        "parameter_unitstyle": unit,      # 0 int, 1 float, 2 ms, 4 dB, 5 %, 7 st
    }
    if exponent is not None:
        v["parameter_exponent"] = exponent
    if enum is not None:
        v["parameter_enum"] = enum
    if steps is not None:
        v["parameter_steps"] = steps
    if invisible is not None:
        v["parameter_invisible"] = invisible
    return {"valueof": v}


# --------------------------------------------------------------------------
# Voice patcher: one instance per voice inside [poly~]
# Incoming list (via poly~ "midinote"):  pitch  vel  sampleIndex  semitones  amp  pan
#   note-on : sampleIndex >= 1, plays <pool>.<index> transposed by `semitones`
#   note-off: "pitch 0 0 0 0 0" -> envelope release
#   pan: -1 (left) .. 0 (centre) .. 1 (right), applied when the note starts
# #1 = the pool name, passed with [poly~ ... @args ---mkpool]
# --------------------------------------------------------------------------
def build_voice():
    v = Patcher()
    inl = v.obj("in 1", 0, 1)
    unp = v.obj("unpack 0 0 0 0. 0. 0.", 1, 6,
                ["int", "int", "int", "float", "float", "float"])
    v.wire(inl, 0, unp)

    pan_store = v.obj("f", 2, 1, ["float"])
    v.wire(unp, 5, pan_store, 1)

    amp_store = v.obj("f", 2, 1, ["float"])
    v.wire(unp, 4, amp_store, 1)

    ratio = v.obj(r"expr pow(2.\, $f1/12.)", 1, 1)
    rate_store = v.obj("f", 2, 1, ["float"])
    v.wire(unp, 3, ratio)
    v.wire(ratio, 0, rate_store, 1)

    idx_sel = v.obj("sel 0", 2, 2, ["bang", ""])
    v.wire(unp, 2, idx_sel)
    start = v.obj("t b b b b i", 1, 5, ["bang", "bang", "bang", "bang", "int"])
    v.wire(idx_sel, 1, start)

    setname = v.obj("sprintf set #1.%ld", 1, 1)
    v.wire(start, 4, setname)

    groove = v.obj("groove~ #1.1 2 @loop 0", 3, 3, ["signal", "signal", "signal"])
    info = v.obj("info~ #1.1", 1, 11, [""] * 11)
    v.wire(setname, 0, groove)
    v.wire(setname, 0, info)
    v.wire(start, 3, info)          # bang -> report channel count

    # pan law: centre = full level on both sides, hard left = left only
    pan_t = v.obj("t f f", 1, 2, ["float", "float"])
    v.wire(start, 2, pan_store)
    v.wire(pan_store, 0, pan_t)
    gain_l = v.obj(r"expr min(1.\, 1.41421*cos(($f1+1.)*0.785398))", 1, 1)
    gain_r = v.obj(r"expr min(1.\, 1.41421*sin(($f1+1.)*0.785398))", 1, 1)
    v.wire(pan_t, 1, gain_l)
    v.wire(pan_t, 0, gain_r)

    sig = v.obj("sig~ 1.", 1, 1, ["signal"])
    v.wire(start, 1, rate_store)
    v.wire(rate_store, 0, sig)
    v.wire(sig, 0, groove)

    go = v.obj("t b b", 1, 2, ["bang", "bang"])
    v.wire(start, 0, go)
    zero = v.msg("0")
    v.wire(go, 1, zero)
    v.wire(zero, 0, groove)          # int in left inlet = start from 0 ms
    v.wire(go, 0, amp_store)

    adsr = v.obj("adsr~ 1 600 1. 250", 5, 4, ["signal", "signal", "", ""])
    v.wire(amp_store, 0, adsr)

    vel_sel = v.obj("sel 0", 2, 2, ["bang", ""])
    v.wire(unp, 1, vel_sel)
    rel = v.msg("0")
    v.wire(vel_sel, 0, rel)
    v.wire(rel, 0, adsr)             # 0 -> release

    # global parameters arrive on a device-local send
    prm = v.obj("r #1-params", 0, 1)
    prm_route = v.obj("route attack decay sustain release", 1, 5)
    v.wire(prm, 0, prm_route)
    for i in range(4):
        v.wire(prm_route, i, adsr, i + 1)

    busy = v.obj("thispoly~", 1, 2, ["int", "int"])
    v.wire(adsr, 0, busy)            # non-zero envelope = voice busy

    # mono samples: copy left into right
    mono = v.obj("== 1", 2, 1, ["int"])
    v.wire(info, 8, mono)            # 9th outlet = channel count
    lmul = v.obj("*~ 0.", 2, 1, ["signal"])
    rsum = v.obj("+~", 2, 1, ["signal"])
    v.wire(mono, 0, lmul, 1)
    v.wire(groove, 0, lmul)
    v.wire(groove, 1, rsum)
    v.wire(lmul, 0, rsum, 1)

    envl = v.obj("*~", 2, 1, ["signal"])
    envr = v.obj("*~", 2, 1, ["signal"])
    v.wire(groove, 0, envl)
    v.wire(adsr, 0, envl, 1)
    v.wire(rsum, 0, envr)
    v.wire(adsr, 0, envr, 1)

    panl = v.obj("*~ 1.", 2, 1, ["signal"])
    panr = v.obj("*~ 1.", 2, 1, ["signal"])
    v.wire(envl, 0, panl)
    v.wire(envr, 0, panr)
    v.wire(gain_l, 0, panl, 1)
    v.wire(gain_r, 0, panr, 1)

    outl = v.obj("out~ 1", 1, 0)
    outr = v.obj("out~ 2", 1, 0)
    v.wire(panl, 0, outl)
    v.wire(panr, 0, outr)

    v.comment("multiKey voice. #1 = pool name. Input: pitch vel index semitones amp pan",
              rect=[400, 10, 400, 20])
    return v


# --------------------------------------------------------------------------
# Main device patcher (Max Instrument)
# --------------------------------------------------------------------------
def build_main():
    m = Patcher()

    # ---------- presentation: labels ----------
    m.comment("multiKey", pres=[8, 4, 120, 22], fontsize=16.0, fontface=1)
    m.comment("v0.2", pres=[100, 9, 40, 16], fontsize=9.0)
    m.comment("ENVELOPE", pres=[200, 8, 120, 16], fontsize=9.0, fontface=1)
    m.comment("PLAY", pres=[390, 8, 80, 16], fontsize=9.0, fontface=1)
    m.comment("RANDOM", pres=[485, 8, 80, 16], fontsize=9.0, fontface=1)

    # ---------- MIDI in ----------
    notein = m.obj("notein", 1, 3, ["int", "int", "int"])
    pk_in = m.obj("pack 0 0", 2, 1)
    m.wire(notein, 0, pk_in, 0)
    m.wire(notein, 1, pk_in, 1)
    rev = m.obj("zl rev", 2, 2)
    m.wire(pk_in, 0, rev)
    route0 = m.obj("route 0", 2, 2)
    m.wire(rev, 0, route0)

    poly = m.obj("poly~ multikey.voice %d @steal 1 @args %s" % (VOICES, POOL),
                 1, 2, ["signal", "signal"])

    # note-off: vel 0 -> release whichever voice holds this pitch
    off = m.msg("midinote $1 0 0 0 0 0")
    m.wire(route0, 0, off)
    m.wire(off, 0, poly)

    # note-on path, gated by "pool not empty"
    gate_n = m.obj("gate 1", 2, 1)
    m.wire(route0, 1, gate_n, 1)
    unp = m.obj("unpack 0 0", 1, 2, ["int", "int"])      # vel pitch
    m.wire(gate_n, 0, unp)

    pk = m.obj("pack 0 0 0 0. 0. 0.", 6, 1)               # pitch vel idx semis amp pan
    pre = m.obj("prepend midinote", 1, 1)
    m.wire(pk, 0, pre)
    m.wire(pre, 0, poly)

    # pitch arrives first (right outlet)
    tp = m.obj("t i i", 1, 2, ["int", "int"])
    m.wire(unp, 1, tp)
    semis = m.obj("expr $i1 - 60 + $i2", 2, 1)            # C3 (60) = original pitch
    m.wire(tp, 1, semis)
    m.wire(semis, 0, pk, 3)
    pstore = m.obj("i", 2, 1, ["int"])
    m.wire(tp, 0, pstore, 1)

    # then velocity: pick sample (+ reseed), pan, amp, vel, then fire with pitch
    tv = m.obj("t b i b i b", 1, 5, ["bang", "int", "bang", "int", "bang"])
    m.wire(unp, 0, tv)
    amp = m.obj(r"expr (1.-$f2) + $f2*pow($f1/127.\, 1.5)", 2, 1)
    m.wire(tv, 3, amp)
    # spread: random pan per note, scaled by the Spread knob (0..1)
    pan_rand = m.obj("random 10001", 2, 1, ["int"])
    pan_scale = m.obj(r"expr ($f1/5000.-1.)*$f2", 2, 1)
    m.wire(tv, 2, pan_rand)
    m.wire(pan_rand, 0, pan_scale)
    m.wire(pan_scale, 0, pk, 5)
    m.wire(amp, 0, pk, 4)
    m.wire(tv, 1, pk, 1)
    m.wire(tv, 0, pstore)
    m.wire(pstore, 0, pk, 0)

    # ---------- sample picker: per-note random, dealt without repeats within a chord ----------
    pick = m.obj("t b b", 1, 2, ["bang", "bang"])
    m.wire(tv, 4, pick)
    once = m.obj("onebang 1", 2, 2, ["bang", "bang"])     # first note of a chord passes
    m.wire(pick, 1, once)
    chord_open = m.obj("t b b b", 1, 3, ["bang", "bang", "bang"])
    m.wire(once, 0, chord_open)
    window = m.obj("delay 30", 2, 1, ["bang"])            # chord window
    m.wire(chord_open, 2, window)
    m.wire(window, 0, once, 1)                            # re-arm after the window
    urn = m.obj("urn 1", 2, 2, ["int", "bang"])
    clr = m.msg("clear")
    m.wire(chord_open, 0, clr)
    m.wire(clr, 0, urn)
    m.wire(pick, 0, urn)
    plus1 = m.obj("+ 1", 2, 1, ["int"])                   # polybuffer~ is 1-based
    m.wire(urn, 0, plus1)
    m.wire(plus1, 0, pk, 2)
    # chord bigger than the pool: start a fresh deal
    refill = m.obj("t b b", 1, 2, ["bang", "bang"])
    m.wire(urn, 1, refill)
    clr2 = m.msg("clear")
    m.wire(refill, 1, clr2)
    m.wire(clr2, 0, urn)
    m.wire(refill, 0, urn)

    # ---------- seed: picks derived from song position (only while Live is playing) ----------
    g_seed = m.obj("gate 1", 2, 1)
    g_play = m.obj("gate 1", 2, 1)
    m.wire(chord_open, 1, g_seed, 1)
    m.wire(g_seed, 0, g_play, 1)
    transport = m.obj("transport", 2, 9, ["int", "int", "float", "float", "float",
                                         "", "int", "float", ""])
    m.wire(g_play, 0, transport)
    quant = m.obj("expr int(($f1+30.)/60.)", 1, 1)        # 1/32-note grid
    m.wire(transport, 7, quant)                           # 8th outlet = raw ticks
    hsh = m.obj(r"expr int(fmod($f1*104729. + $f2*7919.\, 2147483000.)) + 1", 2, 1)
    m.wire(quant, 0, hsh)
    seedmsg = m.obj("prepend seed", 1, 1)
    m.wire(hsh, 0, seedmsg)
    m.wire(seedmsg, 0, urn)
    m.wire(seedmsg, 0, pan_rand)                          # seeded renders keep their panning

    # Live transport state -> g_play
    thisdev = m.obj("live.thisdevice", 1, 3, ["bang", "int", "int"])
    pathmsg = m.msg("path live_set")
    lpath = m.obj("live.path", 1, 3, ["", "", ""])
    propmsg = m.msg("property is_playing")
    obs = m.obj("live.observer", 2, 2, ["", ""])
    m.wire(pathmsg, 0, lpath)
    m.wire(lpath, 0, obs, 1)
    m.wire(propmsg, 0, obs)
    m.wire(obs, 0, g_play)

    # ---------- output ----------
    gain = m.add("live.gain~", pres=[600, 6, 42, 156], numinlets=2, numoutlets=5,
                 outlettype=["signal", "signal", "", "float", "list"],
                 parameter_enable=1, varname="Volume", orientation=1,
                 saved_attribute_attributes=live_param("Volume", 0, -70.0, 6.0, 0.0, 4))
    trim_l = m.obj("*~ 0.447", 2, 1, ["signal"])          # -7 dB headroom
    trim_r = m.obj("*~ 0.447", 2, 1, ["signal"])
    m.wire(poly, 0, trim_l)
    m.wire(poly, 1, trim_r)
    m.wire(trim_l, 0, gain, 0)
    m.wire(trim_r, 0, gain, 1)
    plugout = m.obj("plugout~", 2, 2, ["signal", "signal"])
    m.wire(gain, 0, plugout, 0)
    m.wire(gain, 1, plugout, 1)

    # ---------- parameters ----------
    params = m.obj("s %s-params" % POOL, 1, 0)

    def dial(name, pres, ptype, mmin, mmax, init, unit, exponent=None):
        return m.add("live.dial", pres=pres, numinlets=1, numoutlets=2,
                     outlettype=["", "float"], parameter_enable=1,
                     varname="".join(c for c in name if c.isalnum()),
                     saved_attribute_attributes=live_param(name, ptype, mmin, mmax,
                                                           init, unit, exponent))

    d_att = dial("Attack", [195, 24, 44, 48], 0, 0.0, 5000.0, 1.0, 2, 3.0)
    d_dec = dial("Decay", [240, 24, 44, 48], 0, 1.0, 10000.0, 600.0, 2, 3.0)
    d_sus = dial("Sustain", [285, 24, 44, 48], 0, 0.0, 100.0, 100.0, 5)
    d_rel = dial("Release", [330, 24, 44, 48], 0, 1.0, 10000.0, 250.0, 2, 3.0)
    d_vel = dial("Vel > Vol", [385, 24, 44, 48], 0, 0.0, 100.0, 70.0, 5)
    d_spr = dial("Spread", [385, 90, 44, 48], 0, 0.0, 100.0, 0.0, 5)
    d_trn = dial("Transpose", [430, 24, 44, 48], 1, -48.0, 48.0, 0.0, 7)

    for d, name in ((d_att, "attack"), (d_dec, "decay"), (d_rel, "release")):
        p = m.obj("prepend %s" % name, 1, 1)
        m.wire(d, 0, p)
        m.wire(p, 0, params)
    sus_scale = m.obj("/ 100.", 2, 1, ["float"])
    sus_p = m.obj("prepend sustain", 1, 1)
    m.wire(d_sus, 0, sus_scale)
    m.wire(sus_scale, 0, sus_p)
    m.wire(sus_p, 0, params)
    vel_scale = m.obj("/ 100.", 2, 1, ["float"])
    m.wire(d_vel, 0, vel_scale)
    m.wire(vel_scale, 0, amp, 1)
    spr_scale = m.obj("/ 100.", 2, 1, ["float"])
    m.wire(d_spr, 0, spr_scale)
    m.wire(spr_scale, 0, pan_scale, 1)
    m.wire(d_trn, 0, semis, 1)

    # chord window + seed controls
    m.comment("Chord window", pres=[485, 24, 80, 16], fontsize=9.0)
    n_win = m.add("live.numbox", pres=[485, 40, 50, 15], numinlets=1, numoutlets=2,
                  outlettype=["", "float"], parameter_enable=1, varname="Chord Window",
                  saved_attribute_attributes=live_param("Chord Window", 0, 0.0, 100.0,
                                                        30.0, 2))
    m.wire(n_win, 0, window, 1)

    t_seed = m.add("live.text", pres=[485, 66, 50, 16], numinlets=1, numoutlets=2,
                   outlettype=["", ""], parameter_enable=1, varname="Seed", mode=1,
                   text="Seed", texton="Seed",
                   saved_attribute_attributes=live_param("Seed", 2, 0.0, 1.0, 0.0, 9,
                                                         enum=["off", "on"]))
    m.wire(t_seed, 0, g_seed)
    n_seed = m.add("live.numbox", pres=[540, 66, 50, 16], numinlets=1, numoutlets=2,
                   outlettype=["", "float"], parameter_enable=1, varname="Seed Value",
                   saved_attribute_attributes=live_param("Seed Value", 0, 1.0, 9999.0,
                                                         1.0, 0, steps=9999))
    m.wire(n_seed, 0, hsh, 1)
    t_reroll = m.add("live.text", pres=[485, 86, 105, 16], numinlets=1, numoutlets=2,
                     outlettype=["", ""], parameter_enable=0, mode=0, text="Re-roll")
    rr_route = m.obj("route bang 1", 1, 3)
    rr_rand = m.obj("random 9999", 2, 1, ["int"])
    rr_plus = m.obj("+ 1", 2, 1, ["int"])
    m.wire(t_reroll, 0, rr_route)
    m.wire(rr_route, 0, rr_rand)
    m.wire(rr_route, 1, rr_rand)
    m.wire(rr_rand, 0, rr_plus)
    m.wire(rr_plus, 0, n_seed)

    # ---------- sample pool ----------
    m.add("panel", pres=[8, 28, 176, 60], numinlets=1, numoutlets=0,
          bgcolor=[0.2, 0.2, 0.2, 1.0], rounded=4, background=1)
    m.comment("Drop a folder of one-shots here", pres=[16, 50, 170, 16], fontsize=9.0)
    drop = m.add("dropfile", pres=[8, 28, 176, 60], numinlets=1, numoutlets=2,
                 outlettype=["", ""])
    polybuf = m.obj("polybuffer~ %s" % POOL, 1, 2)
    loader = m.obj("js multikey_loader.js %s" % POOL, 1, 3)
    p_drop = m.obj("prepend drop", 1, 1)
    p_type = m.obj("prepend droptype", 1, 1)
    m.wire(drop, 1, p_type)
    m.wire(drop, 0, p_drop)
    m.wire(p_type, 0, loader)
    m.wire(p_drop, 0, loader)

    def button(label, pres, message):
        b = m.add("live.text", pres=pres, numinlets=1, numoutlets=2,
                  outlettype=["", ""], parameter_enable=0, mode=0, text=label)
        r = m.obj("route bang 1", 1, 3)
        mm = m.msg(message)
        m.wire(b, 0, r)
        m.wire(r, 0, mm)
        m.wire(r, 1, mm)
        m.wire(mm, 0, loader)
        return b

    button("Load folder", [8, 92, 80, 16], "loadfolder")
    button("Add file", [92, 92, 50, 16], "addfile")
    button("Clear", [146, 92, 38, 16], "clear")

    menu = m.add("umenu", pres=[8, 112, 176, 18], numinlets=1, numoutlets=3,
                 outlettype=["int", "", ""], items=["(no samples - drop a folder)"])
    m.wire(loader, 1, menu)

    countlbl = m.comment("0 samples", pres=[8, 134, 176, 16], fontsize=9.0)
    rcount = m.obj("route count", 1, 2)
    m.wire(loader, 0, rcount)
    tcount = m.obj("t i i i", 1, 3, ["int", "int", "int"])
    m.wire(rcount, 0, tcount)
    m.wire(tcount, 2, urn, 1)                    # pool size -> urn range
    gt0 = m.obj("> 0", 2, 1, ["int"])
    m.wire(tcount, 1, gt0)
    m.wire(gt0, 0, gate_n)
    cfmt = m.obj("sprintf set %ld samples (all assumed C3)", 1, 1)
    m.wire(tcount, 0, cfmt)
    m.wire(cfmt, 0, countlbl)

    # sample list is saved with the Live set
    pattr = m.obj("pattr mkfiles", 1, 3, ["", "", ""],
                  parameter_enable=1, varname="mkfiles",
                  saved_attribute_attributes=live_param("mkfiles", 3, invisible=1))
    m.wire(loader, 2, pattr)
    p_rest = m.obj("prepend restore", 1, 1)
    m.wire(pattr, 0, p_rest)
    m.wire(p_rest, 0, loader)

    # ---------- init on device load ----------
    tinit = m.obj("t b b b b b b b b b b", 1, 10, ["bang"] * 10)
    m.wire(thisdev, 0, tinit)
    initmsg = m.msg("init")
    m.wire(tinit, 9, initmsg)
    m.wire(initmsg, 0, loader)
    for i, d in enumerate((d_att, d_dec, d_sus, d_rel, d_vel, d_trn, d_spr)):
        m.wire(tinit, 8 - i, d)
    m.wire(tinit, 1, pathmsg)
    m.wire(tinit, 0, propmsg)

    # keep polybuf referenced in layout (it is used by name from js/voices)
    _ = polybuf
    m.comment("multiKey main patcher - generated by tools/build_device.py. Edit the script, not this file.",
              rect=[600, 5, 500, 20])
    return m


def write_amxd(path, patcher_json, device_type=b"iiii"):
    body = json.dumps(patcher_json, indent=1).encode("utf-8") + b"\n\x00"
    with open(path, "wb") as f:
        f.write(b"ampf")
        f.write(struct.pack("<I", 4))
        f.write(device_type)                 # iiii = instrument
        f.write(b"meta")
        f.write(struct.pack("<I", 4))
        f.write(b"\x00\x00\x00\x00")
        f.write(b"ptch")
        f.write(struct.pack("<I", len(body)))
        f.write(body)


def main():
    os.makedirs(OUT, exist_ok=True)

    voice = build_voice().to_json()
    with open(os.path.join(OUT, "multikey.voice.maxpat"), "w") as f:
        json.dump(voice, f, indent=1)

    extra = {
        "openinpresentation": 1,
        "devicewidth": float(DEVICE_WIDTH),
        "latency": 0,
        "is_mpe": 0,
        "dependency_cache": [
            {"name": "multikey.voice.maxpat", "bootpath": ".", "type": "JSON", "implicit": 1},
            {"name": "multikey_loader.js", "bootpath": ".", "type": "TEXT", "implicit": 1},
        ],
    }
    main_json = build_main().to_json(extra)
    with open(os.path.join(OUT, "multiKey.maxpat"), "w") as f:
        json.dump(main_json, f, indent=1)
    write_amxd(os.path.join(OUT, "multiKey.amxd"), main_json)
    print("built:", ", ".join(sorted(os.listdir(OUT))))


if __name__ == "__main__":
    main()
