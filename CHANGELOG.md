# Changelog

## v0.6.3, 2026-11-14
- Fix: Solo button never showed its on state. It lacked a proper on/off parameter definition, so its "on" value was drawn as off. It is now a real on/off toggle (not automated, not saved), in solo blue.

## v0.6.2, 2026-11-14
- Fix: Preview button didn't respond. The invisible drop area under it may have taken the click; the drop area now leaves the Preview corner free.
- Fix: Solo didn't show blue. Live object colours follow the Live theme unless that link is cleared; it now is for the Solo button.

## v0.6.1, 2026-11-14
- Fix: loaded sounds still weren't restored when reopening a set (settings were). The sample list was sent to the storage object with "set", which updates it silently, so Live never saw a change to save. It is now sent as a normal value.
- An empty or initial stored value no longer wipes loaded sounds on load.
- Preview moved to the top-right corner of the waveform (always visible).
- Solo lights up blue while active; Reset also turns Solo off.

## v0.6, 2026-11-14
- Fix: **the sample list is now saved with the Live set.** The storage object's "save with the set" flag was written to the wrong part of the file, so Max ignored it and nothing was saved (v0.1-v0.5).
- New: **Preview** (Sound tab) plays the selected sound once at its original pitch, with its own Volume/Transpose.
- New: **Solo** (Sound tab): every note plays the selected sound; follows the selection. "SOLO" shows next to the sample count while it's on.
- High zone plays an octave down (-12 st) when Zones is on (Low stays +12).

## v0.5.1, 2026-11-14
- Low zone sounds play an octave up (+12 st) when Zones is on, so a bass one-shot recorded at a low C sounds at its own pitch when you play a low C.
- Switching to an empty zone clears the waveform instead of showing the previous zone's sound.

## v0.5, 2026-11-14
- New: **Zones tab** with 3 fixed key zones: Low (up to B1), Mid (C2-B3), High (C4 and up).
  - With Zones on, a Low/Mid/High selector appears under the sound list. Loading, dropping, clearing and the list apply to the selected zone.
  - **Crossfade** (0-12 st, default 3): near a border a note can pick from the neighbouring zone. 50/50 at the border, falling linearly to 0 at the crossfade distance; beyond that is the safe zone (own sounds only).
  - A note in an empty zone borrows from the nearest zone that has sounds.
  - A keyboard picture shows the zones and the crossfade areas.
  - Chord dealing (no repeats) works per zone; Seed also covers the zone choice.
- Zones off = one shared pool, same behaviour as before.
- Load folder now uses a folder dialog and loads into the current zone. Storage format `mk3` adds each sound's zone (older saves load into Mid).

## v0.4.1, 2026-11-14
- Fix: drag and drop onto the waveform stopped working. The waveform display now sits in the background layer, so drops reach the drop target above it.

## v0.4, 2026-11-14
- New layout: the sound pool on the left, tabs on the right. The device is now 720 px wide.
- New: **waveform display** of the selected sound, in place of the drop area (still the drop target for folders and files).
- New: **Global / Sound tabs.** Global holds everything that affects all sounds. Sound has **Volume** (-36..+12 dB) and **Transpose** (±24 st) for the sound selected in the list, plus Reset.
- Per-sound settings are saved with the sample list (storage format `mk2`; old saves still load).
- Swapped Spread and Vel > Vol.
- Removed the MPE range box; per-note bend range is fixed at the MPE standard (48 st).

## v0.3.1, 2026-11-14
- Fix: v0.3 crashed Live when loading samples. The generated file header differed from what Max writes; the header and MPE fields now match a file saved by Max 9.1.
- Fix: per-note MPE bends had no effect. MIDI is now parsed from the raw [midiin] stream (notes + pitch bend with real channels) instead of [notein]/[xbendin], which can report channel 1 for everything in Max for Live.

## v0.3, 2026-11-14
- New: **MPE per-note pitch bend.** Each voice follows the bends on its own MIDI channel (channels 2-16). The device is marked MPE-enabled so Live sends per-note data.
- New: **normal pitch wheel.** Bends on channel 1 move all notes together.
- New: *Wheel* and *MPE* bend-range boxes (defaults 2 and 48 semitones, the MPE standard).
- Output trimmed a further 3 dB (-10 dB total).

## v0.2, 2026-11-14
- New: **Spread** knob, a random pan per note (0% = centre, 100% = anywhere from hard left to hard right). Seeded renders keep their panning.
- Fix: Re-roll got stuck at 256 (Live caps integer parameters at 256 values). Seed Value is now 1-9999.
- Fix: output was too hot and distorted with chords; -7 dB trim before the volume fader.
- "Velocity" knob renamed to **Vel > Vol** (how much note velocity changes loudness).

## v0.1, 2026-11-14 (first prototype, untested in Live)
- Sample pool via polybuffer~: folder drop, folder dialog, add file, clear
- Saves the sample list in the Live set (pattr blob)
- All samples treated as C3, chromatic playback, global transpose
- A random pick per note; the chord window deals unique samples within a chord
- Seed mode: song-position-based picks while Live plays, plus re-roll
- Global ADSR, velocity sensitivity, volume; 32-voice poly~ with stealing
- Patchers generated by tools/build_device.py
