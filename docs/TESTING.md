# Testing multiKey

## v0.3 checks
- [ ] Volume feels right now (another -3 dB)
- [ ] Normal pitch wheel bends all notes; *Wheel* range changes how far
- [ ] MPE controller (or MPE pitch curves drawn in a clip): each note bends on its own
- [ ] Bend sounds smooth, with no zipper/stepping
- [ ] A note that's released doesn't jump when the next note on the same channel bends
- [ ] If per-note bends don't arrive: right-click the device title, check MPE is enabled, and report back

## v0.2 checks
- [ ] Re-roll gives a new number every click (no longer stuck at 256)
- [ ] Chords no longer distort at the default volume
- [ ] Spread at 0%: all notes centred. At 100%: notes land all over the stereo field
- [ ] Seed on + Spread: same panning on every playback from the same position

## Full checklist (v0.1)

Live 12 Suite, macOS. Report what happens at each step. If something fails, open the Max Console (*Max → Window → Max Console*, or right-click the device title → *Edit*, then Window → Max Console) and copy any red errors.

## 1. Load
- [ ] Drag `device/multiKey.amxd` onto a MIDI track. Does it load without errors?
- [ ] Does the device show the UI (drop area, dials, Seed controls, volume fader)?

> If the device doesn't load or looks empty, try the fallback: create an empty **Max Instrument**, click its edit button, open `device/multiKey.maxpat` in Max, *Select All → Copy*, paste into the empty device's editor, then save it next to the other files.

## 2. Samples
- [ ] Drop a folder of one-shots onto the drop area. Does the count update and the menu list the files?
- [ ] *Load folder* button: does a dialog open and load the folder?
- [ ] *Add file*: does it add one sample?
- [ ] *Clear*: does it empty the pool?

## 3. Playing
- [ ] Play single notes. Is each one a random one-shot?
- [ ] Is C3 the original pitch, and are other notes in tune?
- [ ] Play chords by hand. Are the notes different samples?
- [ ] **Program a chord in a MIDI clip** (all notes on the same start). Does each note get a different sample? (This is the main bug we're fixing.)
- [ ] Chord with more notes than samples (e.g. 2 samples, 4-note chord): no dropouts?
- [ ] Mono and stereo samples: both play on both speakers?
- [ ] Samples at 44.1 kHz vs 48 kHz: same pitch?

## 4. Controls
- [ ] Attack / Decay / Sustain / Release behave as expected.
- [ ] Velocity knob: 0% = all notes the same loudness, 100% = very dynamic.
- [ ] Transpose shifts everything by semitones.
- [ ] Chord window at 0 ms: hand-played chords can repeat samples again. At 60 ms: quick arpeggios get dealt like a chord.

## 5. Seed
- [ ] Seed off: a looping clip gives different picks each time.
- [ ] Seed on: play a clip from the same position twice. Are the picks identical?
- [ ] Re-roll: are the picks different, and do they stay consistent afterwards?
- [ ] Bounce/freeze the track twice with Seed on. Do the renders match?

## 6. Save / reload
- [ ] Save the set, close it and reopen it. Are the samples still loaded?
- [ ] Two multiKeys on two tracks with different folders: do they stay independent?

## Feel (most important)
- Does it feel tight when playing? Any latency or flams?
- What's missing or annoying in the first 10 minutes?
