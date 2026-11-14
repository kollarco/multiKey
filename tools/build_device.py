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
DEVICE_WIDTH = 720


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

    def name(self, oid, varname):
        for b in self.boxes:
            if b["box"]["id"] == oid:
                cur = b["box"].get("varname", varname)
                b["box"]["varname"] = "".join(c for c in cur if c.isalnum() or c == "_")
                return b["box"]["varname"]
        raise KeyError(oid)

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
               exponent=None, enum=None, shortname=None, invisible=None, steps=None,
               initial_enable=1):
    v = {
        "parameter_longname": longname,
        "parameter_shortname": shortname or longname,
        "parameter_type": ptype,          # 0 float, 1 int, 2 enum, 3 blob
        "parameter_mmin": mmin,
        "parameter_mmax": mmax,
        "parameter_initial": [initial],
        "parameter_initial_enable": initial_enable,
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
# Incoming list (via poly~ "midinote"):  pitch  vel  sampleIndex  semitones  amp  pan  channel
#   note-on : sampleIndex >= 1, plays <pool>.<index> transposed by `semitones`
#   note-off: "pitch 0 0 0 0 0 0" -> envelope release, stop following per-note bends
#   pitch bend (bus #1-bend): "master <semis>" bends every voice,
#                             "note <channel> <semis>" bends the voice playing on that channel (MPE)
#   pan: -1 (left) .. 0 (centre) .. 1 (right), applied when the note starts
# #1 = the pool name, passed with [poly~ ... @args ---mkpool]
# --------------------------------------------------------------------------
def build_voice():
    v = Patcher()
    inl = v.obj("in 1", 0, 1)
    unp = v.obj("unpack 0 0 0 0. 0. 0. 0", 1, 7,
                ["int", "int", "int", "float", "float", "float", "int"])
    v.wire(inl, 0, unp)

    ch_store = v.obj("i", 2, 1, ["int"])
    v.wire(unp, 6, ch_store, 1)

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
    start = v.obj("t b b b b b i", 1, 6, ["bang", "bang", "bang", "bang", "bang", "int"])
    v.wire(idx_sel, 1, start)

    setname = v.obj("sprintf set #1.%ld", 1, 1)
    v.wire(start, 5, setname)

    groove = v.obj("groove~ #1.1 2 @loop 0", 3, 3, ["signal", "signal", "signal"])
    info = v.obj("info~ #1.1", 1, 11, [""] * 11)
    v.wire(setname, 0, groove)
    v.wire(setname, 0, info)
    v.wire(start, 4, info)          # bang -> report channel count

    # pan law: centre = full level on both sides, hard left = left only
    pan_t = v.obj("t f f", 1, 2, ["float", "float"])
    v.wire(start, 3, pan_store)
    v.wire(pan_store, 0, pan_t)
    gain_l = v.obj(r"expr min(1.\, 1.41421*cos(($f1+1.)*0.785398))", 1, 1)
    gain_r = v.obj(r"expr min(1.\, 1.41421*sin(($f1+1.)*0.785398))", 1, 1)
    v.wire(pan_t, 1, gain_l)
    v.wire(pan_t, 0, gain_r)

    sig = v.obj("sig~ 1.", 1, 1, ["signal"])
    v.wire(start, 2, rate_store)
    v.wire(rate_store, 0, sig)

    # ---- pitch bend: rate = note rate * 2^((noteBend + masterBend)/12), smoothed ----
    bend_pak = v.obj("pak 0. 0.", 2, 1)                    # noteBend masterBend
    bend_ratio = v.obj(r"expr pow(2.\, ($f1+$f2)/12.)", 1, 1)
    bend_ramp = v.msg("$1 3")
    bend_line = v.obj("line~ 1.", 2, 2, ["signal", "bang"])
    v.wire(bend_pak, 0, bend_ratio)
    v.wire(bend_ratio, 0, bend_ramp)
    v.wire(bend_ramp, 0, bend_line)
    rate_mul = v.obj("*~", 2, 1, ["signal"])
    v.wire(sig, 0, rate_mul)
    v.wire(bend_line, 0, rate_mul, 1)
    v.wire(rate_mul, 0, groove)

    # which channel this voice follows: set at note-on, 0 at note-off
    my_ch = v.obj("== 0", 2, 1, ["int"])
    on_ch = v.obj("t i b", 1, 2, ["int", "bang"])
    zero_bend = v.msg("0.")
    v.wire(start, 1, ch_store)
    v.wire(ch_store, 0, on_ch)
    v.wire(on_ch, 1, zero_bend)
    v.wire(zero_bend, 0, bend_pak, 0)                     # new note starts unbent
    v.wire(on_ch, 0, my_ch, 1)

    bend_r = v.obj("r #1-bend", 0, 1)
    bend_route = v.obj("route note master", 1, 3)
    v.wire(bend_r, 0, bend_route)
    v.wire(bend_route, 1, bend_pak, 1)                    # master bend
    nb_unp = v.obj("unpack 0 0.", 1, 2, ["int", "float"])
    nb_store = v.obj("f", 2, 1, ["float"])
    nb_sel = v.obj("sel 1", 2, 2, ["bang", ""])
    v.wire(bend_route, 0, nb_unp)
    v.wire(nb_unp, 1, nb_store, 1)
    v.wire(nb_unp, 0, my_ch)
    v.wire(my_ch, 0, nb_sel)
    v.wire(nb_sel, 0, nb_store)
    v.wire(nb_store, 0, bend_pak, 0)

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
    stop_follow = v.msg("0")
    v.wire(vel_sel, 0, stop_follow)
    v.wire(stop_follow, 0, my_ch, 1)                      # released voice ignores later bends
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

    v.comment("multiKey voice. #1 = pool name. Input: pitch vel index semitones amp pan channel",
              rect=[400, 10, 400, 20])
    return v


# --------------------------------------------------------------------------
# Main device patcher (Max Instrument)
# --------------------------------------------------------------------------
def build_main():
    m = Patcher()

    # ---------- presentation ----------
    # left: title, waveform (drop target), sound list, buttons
    # right: tabs. GLOBAL = all sounds, SOUND = the sound selected in the list
    G = []   # boxes shown on the Global tab
    S = []   # boxes shown on the Sound tab
    m.comment("multiKey", pres=[8, 4, 80, 22], fontsize=16.0, fontface=1)
    m.comment("v0.4.1", pres=[84, 9, 34, 16], fontsize=9.0)
    G.append(m.comment("ENVELOPE", pres=[256, 24, 120, 14], fontsize=9.0, fontface=1))
    G.append(m.comment("PLAY", pres=[444, 24, 80, 14], fontsize=9.0, fontface=1))
    G.append(m.comment("RANDOM", pres=[548, 24, 80, 14], fontsize=9.0, fontface=1))

    # ---------- MIDI in: raw stream parser ----------
    # [notein]/[xbendin] can report channel 1 for everything in Max for Live, which breaks
    # MPE. So we parse raw [midiin] bytes ourselves: "type channel data1 data2".
    midiin = m.obj("midiin", 1, 1, ["int"])
    sp_data = m.obj("split 0 127", 3, 2, ["int", "int"])
    m.wire(midiin, 0, sp_data)
    sp_stat = m.obj("split 128 239", 3, 2, ["int", "int"])  # channel messages only
    m.wire(sp_data, 1, sp_stat)
    st_t = m.obj("t i i b", 1, 3, ["int", "int", "bang"])
    m.wire(sp_stat, 0, st_t)
    st_type = m.obj("expr $i1 >> 4", 1, 1)
    st_ch = m.obj("expr ($i1 & 15) + 1", 1, 1)
    type_store = m.obj("i", 2, 1, ["int"])
    ch_store = m.obj("i", 2, 1, ["int"])
    grp = m.obj("zl group 2", 2, 2)
    grp_clr = m.msg("zlclear")
    m.wire(st_t, 2, grp_clr)                              # new status: drop partial data
    m.wire(grp_clr, 0, grp)
    m.wire(st_t, 1, st_ch)
    m.wire(st_ch, 0, ch_store, 1)
    m.wire(st_t, 0, st_type)
    m.wire(st_type, 0, type_store, 1)
    m.wire(sp_data, 0, grp)                               # data bytes, paired (running status ok)
    ev_t = m.obj("t b l b", 1, 3, ["bang", "", "bang"])
    m.wire(grp, 0, ev_t)
    ev_pk = m.obj("pack 0 0 0 0", 4, 1)                   # type ch d1 d2
    ev_unp = m.obj("unpack 0 0", 1, 2, ["int", "int"])
    m.wire(ev_t, 2, ch_store)
    m.wire(ch_store, 0, ev_pk, 1)
    m.wire(ev_t, 1, ev_unp)
    m.wire(ev_unp, 1, ev_pk, 3)
    m.wire(ev_unp, 0, ev_pk, 2)
    m.wire(ev_t, 0, type_store)
    m.wire(type_store, 0, ev_pk, 0)
    ev_route = m.obj("route 9 8 14", 1, 4)                # note-on, note-off, pitch bend
    m.wire(ev_pk, 0, ev_route)
    # note-off -> note-on with velocity 0
    off_slice = m.obj("zl slice 2", 2, 2)
    off_app = m.obj("append 0", 1, 1)
    m.wire(ev_route, 1, off_slice)
    m.wire(off_slice, 0, off_app)
    # notes: "ch pitch vel" -> channel first (cold), then "pitch vel"
    note_t = m.obj("t l l", 1, 2, ["", ""])
    m.wire(ev_route, 0, note_t)
    m.wire(off_app, 0, note_t)
    note_ch = m.obj("zl nth 1", 2, 2)
    note_pv = m.obj("zl slice 1", 2, 2)
    m.wire(note_t, 1, note_ch)
    m.wire(note_t, 0, note_pv)
    pk_in = m.obj("pack 0 0", 2, 1)
    m.wire(note_pv, 1, pk_in)
    # bends: "ch lsb msb" -> value 0..16383
    bend_t = m.obj("t l l", 1, 2, ["", ""])
    m.wire(ev_route, 2, bend_t)
    bend_ch = m.obj("zl nth 1", 2, 2)
    bend_val = m.obj("expr $i2 + $i3*128", 3, 1)
    m.wire(bend_t, 1, bend_ch)
    m.wire(bend_t, 0, bend_val)

    rev = m.obj("zl rev", 2, 2)
    m.wire(pk_in, 0, rev)
    route0 = m.obj("route 0", 2, 2)
    m.wire(rev, 0, route0)

    poly = m.obj("poly~ multikey.voice %d @steal 1 @args %s" % (VOICES, POOL),
                 1, 2, ["signal", "signal"])

    # note-off: vel 0 -> release whichever voice holds this pitch
    off = m.msg("midinote $1 0 0 0 0 0 0")
    m.wire(route0, 0, off)
    m.wire(off, 0, poly)

    # note-on path, gated by "pool not empty"
    gate_n = m.obj("gate 1", 2, 1)
    m.wire(route0, 1, gate_n, 1)
    unp = m.obj("unpack 0 0", 1, 2, ["int", "int"])      # vel pitch
    m.wire(gate_n, 0, unp)

    pk = m.obj("pack 0 0 0 0. 0. 0. 0", 7, 1)             # pitch vel idx semis amp pan channel
    m.wire(note_ch, 0, pk, 6)                             # channel arrives first (cold)
    pre = m.obj("prepend midinote", 1, 1)
    m.wire(pk, 0, pre)
    m.wire(pre, 0, poly)

    # pitch arrives first (right outlet)
    tp = m.obj("t i i", 1, 2, ["int", "int"])
    m.wire(unp, 1, tp)
    semis = m.obj("expr $i1 - 60 + $i2", 2, 1)            # C3 (60) = original pitch
    m.wire(tp, 1, semis)
    snd_add = m.obj("+ 0.", 2, 1, ["float"])              # + per-sound transpose (at pick time)
    m.wire(semis, 0, snd_add, 1)
    m.wire(snd_add, 0, pk, 3)
    pstore = m.obj("i", 2, 1, ["int"])
    m.wire(tp, 0, pstore, 1)

    # then velocity: pick sample (+ reseed), pan, amp, vel, then fire with pitch
    tv = m.obj("t b i b i b", 1, 5, ["bang", "int", "bang", "int", "bang"])
    m.wire(unp, 0, tv)
    amp = m.obj(r"expr ((1.-$f2) + $f2*pow($f1/127.\, 1.5)) * $f3", 3, 1)  # $f3 = sound gain
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
    idx_t = m.obj("t i i", 1, 2, ["int", "int"])
    m.wire(plus1, 0, idx_t)
    snd_coll = m.obj("coll", 1, 4, ["", "", "", ""])      # index -> gain semitones (filled by js)
    snd_unp = m.obj("unpack 0. 0.", 1, 2, ["float", "float"])
    m.wire(idx_t, 1, snd_coll)
    m.wire(snd_coll, 0, snd_unp)
    m.wire(snd_unp, 1, snd_add)
    m.wire(snd_unp, 0, amp, 2)
    m.wire(idx_t, 0, pk, 2)
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
    gain = m.add("live.gain~", pres=[668, 6, 44, 156], numinlets=2, numoutlets=5,
                 outlettype=["signal", "signal", "", "float", "list"],
                 parameter_enable=1, varname="Volume", orientation=1,
                 saved_attribute_attributes=live_param("Volume", 0, -70.0, 6.0, 0.0, 4))
    trim_l = m.obj("*~ 0.316", 2, 1, ["signal"])          # -10 dB headroom
    trim_r = m.obj("*~ 0.316", 2, 1, ["signal"])
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

    d_att = dial("Attack", [256, 38, 44, 48], 0, 0.0, 5000.0, 1.0, 2, 3.0)
    d_dec = dial("Decay", [300, 38, 44, 48], 0, 1.0, 10000.0, 600.0, 2, 3.0)
    d_sus = dial("Sustain", [344, 38, 44, 48], 0, 0.0, 100.0, 100.0, 5)
    d_rel = dial("Release", [388, 38, 44, 48], 0, 1.0, 10000.0, 250.0, 2, 3.0)
    d_spr = dial("Spread", [444, 38, 44, 48], 0, 0.0, 100.0, 0.0, 5)
    d_trn = dial("Transpose", [488, 38, 44, 48], 1, -48.0, 48.0, 0.0, 7)
    d_vel = dial("Vel > Vol", [444, 100, 44, 48], 0, 0.0, 100.0, 70.0, 5)
    G.extend([d_att, d_dec, d_sus, d_rel, d_spr, d_trn, d_vel])

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
    G.append(m.comment("Chord window", pres=[548, 38, 80, 14], fontsize=9.0))
    n_win = m.add("live.numbox", pres=[548, 52, 60, 15], numinlets=1, numoutlets=2,
                  outlettype=["", "float"], parameter_enable=1, varname="Chord Window",
                  saved_attribute_attributes=live_param("Chord Window", 0, 0.0, 100.0,
                                                        30.0, 2))
    m.wire(n_win, 0, window, 1)

    t_seed = m.add("live.text", pres=[548, 74, 60, 16], numinlets=1, numoutlets=2,
                   outlettype=["", ""], parameter_enable=1, varname="Seed", mode=1,
                   text="Seed", texton="Seed",
                   saved_attribute_attributes=live_param("Seed", 2, 0.0, 1.0, 0.0, 9,
                                                         enum=["off", "on"]))
    m.wire(t_seed, 0, g_seed)
    n_seed = m.add("live.numbox", pres=[548, 94, 60, 16], numinlets=1, numoutlets=2,
                   outlettype=["", "float"], parameter_enable=1, varname="Seed Value",
                   saved_attribute_attributes=live_param("Seed Value", 0, 1.0, 9999.0,
                                                         1.0, 0, steps=9999))
    m.wire(n_seed, 0, hsh, 1)
    t_reroll = m.add("live.text", pres=[548, 114, 60, 16], numinlets=1, numoutlets=2,
                     outlettype=["", ""], parameter_enable=0, mode=0, text="Re-roll")
    rr_route = m.obj("route bang 1", 1, 3)
    rr_rand = m.obj("random 9999", 2, 1, ["int"])
    rr_plus = m.obj("+ 1", 2, 1, ["int"])
    m.wire(t_reroll, 0, rr_route)
    m.wire(rr_route, 0, rr_rand)
    m.wire(rr_route, 1, rr_rand)
    m.wire(rr_rand, 0, rr_plus)
    m.wire(rr_plus, 0, n_seed)
    G.extend([n_win, t_seed, n_seed, t_reroll])

    # ---------- pitch bend / MPE ----------
    # channel 1 = master bend (all notes, normal pitch wheel), channels 2-16 = per-note (MPE)
    xb_pk = m.obj("pack 0 0", 2, 1)                       # value channel
    m.wire(bend_ch, 0, xb_pk, 1)
    m.wire(bend_val, 0, xb_pk, 0)
    xb_rev = m.obj("zl rev", 2, 2)
    m.wire(xb_pk, 0, xb_rev)
    xb_route = m.obj("route 1", 2, 2)
    m.wire(xb_rev, 0, xb_route)
    bendbus = m.obj("s %s-bend" % POOL, 1, 0)
    master_semis = m.obj("expr ($f1-8192.)/8192.*$f2", 2, 1)
    master_p = m.obj("prepend master", 1, 1)
    m.wire(xb_route, 0, master_semis)
    m.wire(master_semis, 0, master_p)
    m.wire(master_p, 0, bendbus)
    nb_unp = m.obj("unpack 0 0", 1, 2, ["int", "int"])    # channel value
    nb_semis = m.obj("expr ($f1-8192.)/8192.*48.", 1, 1)   # MPE standard range
    nb_pk = m.obj("pack 0 0.", 2, 1)
    nb_p = m.obj("prepend note", 1, 1)
    m.wire(xb_route, 1, nb_unp)
    m.wire(nb_unp, 1, nb_semis)
    m.wire(nb_semis, 0, nb_pk, 1)
    m.wire(nb_unp, 0, nb_pk, 0)
    m.wire(nb_pk, 0, nb_p)
    m.wire(nb_p, 0, bendbus)

    G.append(m.comment("Wheel range", pres=[488, 100, 60, 14], fontsize=9.0))
    n_pbr = m.add("live.numbox", pres=[488, 116, 44, 15], numinlets=1, numoutlets=2,
                  outlettype=["", "float"], parameter_enable=1, varname="PB Range",
                  saved_attribute_attributes=live_param("PB Range", 1, 0.0, 48.0, 2.0, 7))
    m.wire(n_pbr, 0, master_semis, 1)
    G.append(n_pbr)

    # ---------- sample pool ----------
    wave = m.add("waveform~", pres=[8, 26, 236, 80], numinlets=5, numoutlets=6,
                 outlettype=["float", "float", "float", "float", "list", ""],
                 ignoreclick=1, background=1,       # behind the drop target, like the old panel
                 bgcolor=[0.12, 0.12, 0.12, 1.0],
                 waveformcolor=[0.55, 0.83, 0.93, 1.0],
                 selectioncolor=[0.0, 0.0, 0.0, 0.0])
    drop = m.add("dropfile", pres=[8, 26, 236, 80], numinlets=1, numoutlets=2,
                 outlettype=["", ""], border=0)      # on top of the waveform
    polybuf = m.obj("polybuffer~ %s" % POOL, 1, 2)
    loader = m.obj("js multikey_loader.js %s" % POOL, 1, 6)
    m.wire(loader, 3, snd_coll)
    m.wire(loader, 4, wave)
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

    button("Load folder", [8, 132, 90, 16], "loadfolder")
    button("Add file", [102, 132, 70, 16], "addfile")
    button("Clear", [176, 132, 68, 16], "clear")

    menu = m.add("umenu", pres=[8, 110, 236, 18], numinlets=1, numoutlets=3,
                 outlettype=["int", "", ""], items=["(no samples - drop a folder)"])
    m.wire(loader, 1, menu)
    p_sel = m.obj("prepend select", 1, 1)
    m.wire(menu, 0, p_sel)
    m.wire(p_sel, 0, loader)

    countlbl = m.comment("drop a folder on the waveform", pres=[118, 9, 126, 14],
                         fontsize=9.0, textjustification=2)
    rcount = m.obj("route count", 1, 2)
    m.wire(loader, 0, rcount)
    tcount = m.obj("t i i i", 1, 3, ["int", "int", "int"])
    m.wire(rcount, 0, tcount)
    m.wire(tcount, 2, urn, 1)                    # pool size -> urn range
    gt0 = m.obj("> 0", 2, 1, ["int"])
    m.wire(tcount, 1, gt0)
    m.wire(gt0, 0, gate_n)
    cfmt = m.obj("sprintf set %ld samples", 1, 1)
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

    # ---------- Sound tab: settings for the sound selected in the list ----------
    S.append(m.comment("No sound selected", pres=[256, 26, 300, 16], fontsize=11.0, fontface=1))
    snd_name = S[-1]
    S.append(m.comment("Settings for the sound selected in the list on the left. "
                       "Applies on top of the Global settings.",
                       pres=[256, 44, 300, 28], fontsize=9.0, linecount=2))

    def snd_dial(longname, short, pres, mmin, mmax, unit, ptype):
        return m.add("live.dial", pres=pres, numinlets=1, numoutlets=2,
                     outlettype=["", "float"], parameter_enable=1,
                     varname="".join(c for c in longname if c.isalnum()),
                     saved_attribute_attributes=live_param(
                         longname, ptype, mmin, mmax, 0.0, unit, shortname=short,
                         invisible=2, initial_enable=0))   # hidden: values live in js
    d_svol = snd_dial("Sound Volume", "Volume", [256, 78, 44, 48], -36.0, 12.0, 4, 0)
    d_strn = snd_dial("Sound Transpose", "Transpose", [304, 78, 44, 48], -24.0, 24.0, 7, 1)
    t_sreset = m.add("live.text", pres=[360, 94, 60, 16], numinlets=1, numoutlets=2,
                     outlettype=["", ""], parameter_enable=0, mode=0, text="Reset")
    S.extend([d_svol, d_strn, t_sreset])
    p_svol = m.obj("prepend soundvol", 1, 1)
    p_strn = m.obj("prepend soundtrn", 1, 1)
    m.wire(d_svol, 0, p_svol)
    m.wire(d_strn, 0, p_strn)
    m.wire(p_svol, 0, loader)
    m.wire(p_strn, 0, loader)
    sr_route = m.obj("route bang 1", 1, 3)
    sr_msg = m.msg("soundreset")
    m.wire(t_sreset, 0, sr_route)
    m.wire(sr_route, 0, sr_msg)
    m.wire(sr_route, 1, sr_msg)
    m.wire(sr_msg, 0, loader)
    ui_route = m.obj("route name vol trn", 1, 4)
    m.wire(loader, 5, ui_route)
    m.wire(ui_route, 0, snd_name)
    m.wire(ui_route, 1, d_svol)
    m.wire(ui_route, 2, d_strn)

    # ---------- tabs ----------
    tab = m.add("live.tab", pres=[256, 4, 140, 16], numinlets=1, numoutlets=3,
                outlettype=["", "", "float"], parameter_enable=1, varname="Tab",
                num_lines_patching=1, num_lines_presentation=1,
                saved_attribute_attributes=live_param("Tab", 2, 0.0, 1.0, 0.0, 9,
                                                      enum=["Global", "Sound"],
                                                      invisible=1))
    gnames = [m.name(o, "g_%s" % o.replace("-", "")) for o in G]
    snames = [m.name(o, "s_%s" % o.replace("-", "")) for o in S]
    show_global = m.msg(", ".join(["script show %s" % n for n in gnames] +
                                  ["script hide %s" % n for n in snames]))
    show_sound = m.msg(", ".join(["script hide %s" % n for n in gnames] +
                                 ["script show %s" % n for n in snames]))
    tab_sel = m.obj("sel 0 1", 3, 3, ["bang", "bang", ""])
    tp_this = m.obj("thispatcher", 1, 2, ["", ""])
    m.wire(tab, 0, tab_sel)
    m.wire(tab_sel, 0, show_global)
    m.wire(tab_sel, 1, show_sound)
    m.wire(show_global, 0, tp_this)
    m.wire(show_sound, 0, tp_this)

    # ---------- init on device load (right to left) ----------
    init_targets = [tab, "init", d_att, d_dec, d_sus, d_rel, d_vel, d_trn, d_spr, n_pbr,
                    "path", "prop"]
    n = len(init_targets)
    tinit = m.obj("t " + " ".join(["b"] * n), 1, n, ["bang"] * n)
    m.wire(thisdev, 0, tinit)
    initmsg = m.msg("init")
    m.wire(initmsg, 0, loader)
    for i, t in enumerate(init_targets):
        outlet = n - 1 - i
        dst = {"init": initmsg, "path": pathmsg, "prop": propmsg}.get(t, t)
        m.wire(tinit, outlet, dst)

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
        f.write(struct.pack("<I", 1))        # value Max 9 writes
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
        "is_mpe": 1,                 # receive per-note channels/bends from Live
        "external_mpe_tuning_enabled": 0,
        "minimum_live_version": "",
        "minimum_max_version": "",
        "platform_compatibility": 0,
        "project": {
            "version": 1, "creationdate": 3877494390, "modificationdate": 3877494390,
            "viewrect": [0.0, 0.0, 300.0, 500.0], "autoorganize": 1, "hideprojectwindow": 1,
            "showdependencies": 1, "autolocalize": 0, "contents": {"patchers": {}},
            "layout": {}, "searchpath": {}, "detailsvisible": 0,
            "amxdtype": 1768515945, "readonly": 0, "devpathtype": 0, "devpath": ".",
            "sortmode": 0, "viewmode": 0, "includepackages": 0,
        },
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
