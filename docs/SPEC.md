# multiKey: spec and design notes

## Vision

A sampler for producers who play chords and melodies with one-shots. Each note gets a random one-shot from a pool, it stays playable chromatically, and it behaves the same whether you play by hand or click MIDI in.

Audience, in order: me → friends (testers) → my audience (possible release). Ableton-first as Max for Live; a VST/AU port (JUCE) is an option later if it proves useful.

## Problems it solves

1. **Slow preset building.** Swapping out every Simpler in a rack takes forever. → Drop a folder, done.
2. **Programmed chords repeat one sample.** A rack's randomizer draws one value per moment, so notes on the same tick all get the same Simpler. → Each note draws its own pick, and chord notes are dealt without repeats.

## Why not Simpler-based

Live 12.4's Live API can load samples into Simpler (`SimplerDevice.replace_sample`), but a rack can only route a note to a chain by key zone (changes pitch), velocity zone (loses dynamics) or chain selector (one value for all simultaneous notes). There's no clean per-note random routing that keeps pitch and velocity, so multiKey does its own sample playback.

## Scope

### v0.1 (done): the core "multikey" behaviour
- One sample pool, any size; folder drop / folder dialog / add file / remove selected / clear
- All samples assumed root **C3 = MIDI 60**; global transpose
- A random pick per note, plus a chord window that deals unique samples within a chord
- Seed: song-position-based picks while Live plays (reproducible renders), plus re-roll
- Global ADSR, velocity sensitivity, volume, 32 voices with voice stealing
- Sample list saved in the Live set

### v0.2 (done)
- Spread (random pan per note), seed fix, -7 dB output trim, "Vel > Vol" naming

### v0.3 (done)
- MPE per-note pitch bend (voices follow their own MIDI channel), pitch wheel on channel 1, bend ranges, -10 dB total trim

### v0.4 (done)
- Layout: pool + waveform left; Global / Sound tabs right. Per-sound Volume + Transpose (saved). Spread/Vel swap. MPE range fixed at 48.
- Per-sound envelopes deliberately left out (global vs per-sound envelopes gets confusing)

### v0.5
- Zones tab: 3 fixed zones (Low ≤ B1, Mid C2–B3, High ≥ C4), on/off, Crossfade 0–12 st with linear 50%→0% probability, keyboard picture, empty-zone fallback
- v0.5.1: Low zone +12 st (bass samples are usually recorded low); waveform blanks on an empty zone
- Customisable zone borders / per-zone octave: later

### v0.6
- Saving fixed (pattr parameter mode lives in saved_object_attributes); Preview + Solo on the Sound tab; High zone −12 st
- v0.6.1: sample list sent to pattr as a normal value (not "set") so Live registers the change; Preview on the waveform; blue Solo; Reset ends Solo

### v0.7
- Crash-safe loading: drops batched into one load; buffers never freed mid-session (removed sounds become unused orphans); compact rebuild only on set restore; slot map from zone position to buffer index
- Reset button removed (v0.6.4); Solo is a proper on/off toggle (v0.6.3)

### v0.8
- Remove button: drops only the selected sound (crash-safe, same orphan-buffer approach); selection moves to the neighbour

### Next candidates
- MPE slide (CC74) and pressure → e.g. filter / volume per note
- One-shot mode (ignore note-off, always play the full sample)
- No immediate repeats for single notes too (melody lines)
- Per-slot tuning / root note, and reading the key from filenames (`pluck_F#.wav`)
- Previous/next folder buttons to audition packs while a loop plays
- Shareable presets (folder of samples + settings file)
- Sample start offset, filter, pan / pitch randomisation per voice
- Weighted random, slot mute/solo, layering two samples per note

### Later
- **Zones, customisable:** movable borders, maybe a 4th zone, zone-level width (mono for bass), low-cut and level. Hierarchy: global → zone → sound.
- VST/AU port.

## Architecture (v0.7)

```
notes ─► [route note-on / note-off]
            │ note-on (only if pool not empty)
            ▼
   pitch ─► semitones = pitch − 60 + transpose
   vel   ─► amp (velocity curve)
         ─► picker: onebang + delay (chord window) → clear urn on the first note of a chord
                    zone table [coll] (by pitch: zone, neighbour, P(neighbour)) + random → zone
                    urn of that zone (random without repeats) + zone key (z·1000) → slot map [coll] → buffer index
                    (urns: Low, Mid, High, All; Solo overrides the buffer index)
                    coll lookup (filled by js) → per-sound gain → amp, per-sound semitones → pitch
                    seed on & Live playing → urn reseeded from song position
         ─► pan = random(−1..1) × Spread (seeded together with the pick)
         ─► "midinote pitch vel index semitones amp pan channel" → poly~ (32 voices) → −10 dB trim → volume
midiin (raw parser) ─► notes with real channels; pitch bend: channel 1 → "master <semis>" (all voices); channels 2-16 → "note <ch> <semis>" (MPE)
           broadcast on <pool>-bend; each voice follows the channel of its current note

poly~ voice: groove~ plays <pool>.<index> at rate 2^(semitones/12), adsr~ envelope,
             mono samples copied to both channels, pan applied at note start,
             envelope drives thispoly~ busy state

polybuffer~ <pool>  ◄── js multikey_loader.js (drop / dialogs / clear / select / per-sound settings / restore)
                          ├─► coll (index → gain, semitones), waveform~ (selected sound), Sound-tab UI
                          ├─► zone table coll (128 rows), slot map coll, urn sizes
                          └─► pattr (blob) saves "3 path zone dB st ..." in the Live set
tabs: live.tab → thispatcher "script show/hide" on the Global / Sound / Zones box groups
```

### Key decisions
- **The note path uses native Max objects only.** Max's `js` always runs on the low-priority UI thread, which would add timing jitter to every note. JS is only used for loading and saving, where timing doesn't matter.
- **The chord window uses wall-clock time** (`delay`). Programmed chords arrive at the same instant, and hand-played chords usually spread within ~30 ms.
- **The seed is tied to song position**, quantised to a 1/32 grid, so render timing jitter doesn't change the picks. Without the seed (or with Live stopped) picks are fully random.
- **Patchers are generated by `tools/build_device.py`**, so diffs are readable in git.
- **Live integer parameters cap at 256 values**, so wide-range knobs (Seed Value) are float parameters quantised to whole numbers.
- **Raw MIDI parsing:** [notein]/[xbendin] can report channel 1 for everything in Max for Live, so MIDI is parsed from [midiin] bytes.
- **Generated .amxd header must match Max's** (meta chunk value 1, project block). Suspected cause of the v0.3 crash (generated file + MPE flag); the Max-saved version loaded fine.
- **MPE without poly~'s MPE mode:** voices store their note's channel and filter a broadcast bend bus. This keeps our own allocation and extra per-note data (sample, pan) intact.
- **Never free sample buffers mid-session.** polybuffer~ "clear" frees buffers that playing voices / waveform~ may still read; doing that on every drop crashed Live. Sounds get a fixed buffer index; removals leave unused buffers until the next set load, where the pool is rebuilt compactly. Drops are batched (150 ms).
- **Zone logic precomputed in js:** the crossfade curve and empty-zone fallbacks become a 128-row lookup table, so the note path stays a single [coll] lookup plus one random draw.
- **Write stored data to pattr as a normal value**, never with "set": Live only saves a parameter it sees change. The echo back to js is ignored by comparing with the last stored value. The list starts with a number so Max treats it as a plain list.
- **Object-box parameter flags** (e.g. [pattr] parameter mode) go in `saved_object_attributes`, not on the box itself; Max ignores the box-level key.
- **`---` names** make the sample pool unique per device instance, so two multiKeys on two tracks don't share samples.

## Open questions / risks to verify in Live
- ~~Whether the generated `.amxd` loads in Live 12~~ (confirmed, v0.1)
- ~~Whether dropping a folder from Finder works~~ (confirmed, v0.1; v0.4.1 fixed the waveform blocking drops)
- Whether the saved sample list restores on set reload. Cause found in v0.6: parameter mode for object boxes like [pattr] must be in `saved_object_attributes`; verify in Live.
- Voice-busy handling of `adsr~`/`thispoly~` (there was a known bug in Max 9.0.5).
