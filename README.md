# multiKey

A Max for Live instrument for Ableton Live 12: load a pool of one-shots, play chords and melodies, and every note gets a randomly picked one-shot, pitched chromatically.

Built because stacking Simplers in a rack has two problems: swapping samples is slow, and programmed chords (all notes on exactly the same tick) get the same sample on every note.

## Status

**v0.1, first prototype, untested in Live.** Expect rough edges. See [docs/TESTING.md](docs/TESTING.md) for what to try and what to report.

## What it does (v0.1)

- **Sample pool:** drop a folder (or use *Load folder*) to load every one-shot in it. *Add file* adds one sample. The sample list is saved with your Live set.
- **Chromatic playback:** every sample is assumed to be a **C**. C3 (MIDI 60) plays it at its original pitch, and other notes transpose it. A global *Transpose* knob fixes packs that aren't in C.
- **A random pick per note:** each note draws its own sample, so a clicked-in chord no longer repeats one sample on every note.
- **Chord dealing:** notes that land within the *Chord window* (default 30 ms) are dealt different samples, like cards from a shuffled deck. A 4-note chord always gets 4 different one-shots if the pool has at least 4.
- **Seed:** with *Seed* on and Live playing, picks are derived from the song position plus the seed value, so a clip plays the same picks on every playback and bounce. *Re-roll* gives a new set of picks.
- **Global envelope:** attack, decay, sustain and release, plus velocity sensitivity, a volume fader and 32 voices.

## Repo layout

```
device/
  multiKey.amxd           <- drag this into Live (Max Instrument)
  multikey.voice.maxpat   per-voice patcher (must sit next to the .amxd)
  multikey_loader.js      sample loading + saving (must sit next to the .amxd)
  multiKey.maxpat         main patcher as plain JSON (same as inside the .amxd)
tools/
  build_device.py         generates the patchers + .amxd
docs/
  SPEC.md                 vision, scope, roadmap, design decisions
  TESTING.md              test checklist
CHANGELOG.md
```

## Building

The patchers are generated from code, so every change is readable in git:

```
python3 tools/build_device.py
```

Edit `tools/build_device.py` (the wiring) or `device/multikey_loader.js` (loading), then rebuild. Don't hand-edit the generated `.maxpat`/`.amxd` files: the next build overwrites them.

## Sharing with friends

The three files in `device/` must stay together. Before sending it out, open the device in Max and use **Freeze Device**, which bundles the voice patch and the script into the `.amxd`. Saved sample lists point to file paths on your machine, so friends need to load their own samples (shareable presets are on the roadmap).
