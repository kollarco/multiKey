# multiKey

A Max for Live instrument for Ableton Live 12: load a pool of one-shots, play chords and melodies, and every note gets a randomly picked one-shot, pitched chromatically.

Built because stacking Simplers in a rack has two problems: swapping samples is slow, and programmed chords (all notes on exactly the same tick) get the same sample on every note.

---

# Get it running on your Mac (about 5 minutes)

## What you need

| | |
|---|---|
| **Ableton Live 12** | Suite, or Standard with the Max for Live add-on. Tested on Live 12 Suite, macOS, Apple Silicon. |
| **Max for Live** | Included in Suite. You do **not** need to install Max separately just to play. |
| **git** (optional) | Only if you clone. Otherwise use *Download ZIP* on GitHub. macOS offers to install it the first time you type `git`. |
| **Python 3** (optional) | Only if you want to rebuild the device from source. Not needed to play. |
| **A folder of one-shots** | wav, aif/aiff, flac, mp3, m4a, ogg or caf. |

## Quick start

1. **Get the repo** onto your Mac (see *Step 1* below).
2. **Keep the `device` folder together.** `multiKey.amxd`, `multikey.voice.maxpat` and `multikey_loader.js` must stay in the same folder. Never copy the `.amxd` out on its own.
3. In Live, make a **MIDI track**, then drag `device/multiKey.amxd` from Finder onto it.
4. **Drag a folder of one-shots** onto the waveform area (top left of the device).
5. **Play MIDI.** Every note now gets a random one-shot.

If something doesn't work, jump to [Troubleshooting](#troubleshooting).

## Step 1: Get the repo

You need to be added to the GitHub repository first. Accept the invitation email, then pick one:

**A. GitHub Desktop (easiest)**
1. Install [GitHub Desktop](https://desktop.github.com), sign in.
2. *File > Clone Repository*, choose `kollarco/multiKey`, and pick a **permanent** location (see the tip below).

**B. Terminal**
```bash
cd ~/Music            # or any permanent folder you like
git clone https://github.com/kollarco/multiKey.git
```
If it asks for a password, GitHub no longer accepts your account password here. Use a personal access token, or run `gh auth login` first ([GitHub CLI](https://cli.github.com)).

**C. No git: Download ZIP**
On the repo page: *Code > Download ZIP*, then unzip it to a permanent location. Files from a ZIP can be quarantined by macOS. If the device acts strangely, run this once (adjust the path):
```bash
xattr -dr com.apple.quarantine ~/Music/multiKey
```

> **Tip: pick a permanent location** (for example `~/Music/multiKey`, not Downloads or the Desktop). Live looks for the voice patcher and the script next to the device, so moving or deleting the folder later can break sets that use it.

## Step 2: Load the device in Live

1. Open Live and create a **MIDI track**.
2. In Finder, open `multiKey/device/` and **drag `multiKey.amxd` onto the track**. It loads as an instrument.
3. Optional, to find it from Live's browser: in the browser sidebar, *Places > Add Folder...* and choose the `device` folder. Keep the whole folder, not just the `.amxd`.

The first load can take a few seconds. You should see the **multiKey** panel with a drop area on the left and tabs *Global / Sound / Zones* on the right.

## Step 3: Load your one-shots

- **Drag a folder** from Finder onto the waveform area. Every audio file in it is loaded and the old pool is replaced. Or drag several loose files to add them.
- Or use the buttons under the list: **Load folder** (pick a folder), **Add file** (add one sample), **Clear**.
- Use the dropdown to look at any sound. Its waveform shows above it.

**How samples are interpreted:** every one-shot is assumed to be recorded in **C**. **C3 (MIDI 60)** plays it at its original pitch and other notes transpose it. If your pack isn't in C, use the **Transpose** knob on the Global tab, or the per-sound Transpose on the Sound tab.

Tip: 8 to 30 sounds from one family (for example plucks, or pads) is the sweet spot for trying it out.

## Step 4: Play

1. Play a single note: it picks a random one-shot. Play it again: probably a different one.
2. Play or draw a **chord**: each note gets a *different* sound (as long as the pool has enough sounds).
3. Click a chord into a MIDI clip, where every note starts on the exact same tick: it still deals different sounds.

### Quick tour of the controls

| Where | Control | What it does |
|---|---|---|
| Left | Waveform / dropdown | Drop target and the selected sound's waveform. |
| Left | **Preview** (top right of the waveform) | Plays the selected sound once at its original pitch. |
| Left | Load folder, Add file, Clear | Manage the pool. |
| **Global** tab | Attack, Decay, Sustain, Release | Envelope for every sound. |
| **Global** tab | **Spread** | Random stereo position per note. 0% = all centred, 100% = anywhere from hard left to hard right. |
| **Global** tab | Transpose | Shifts everything (use it when your pack isn't in C). |
| **Global** tab | Vel > Vol | How much velocity changes loudness. |
| **Global** tab | Chord window | Notes that arrive within this time (default 30 ms) are dealt different sounds, like cards from a shuffled deck. |
| **Global** tab | **Seed** + Seed Value + **Re-roll** | With Seed on and Live playing, a clip gets the same picks on every playback and bounce. *Re-roll* gives a new set. |
| **Global** tab | Wheel range | Pitch wheel range for a normal keyboard. |
| **Sound** tab | Volume, Transpose | For the selected sound only, on top of the Global settings. |
| **Sound** tab | **Solo** | Every note plays the selected sound, so you can audition it on the keys. Turns blue when on. |
| **Zones** tab | **Zones On/Off** | Splits the keyboard into three pools: **Low** up to B1, **Mid** C2 to B3, **High** from C4. |
| **Zones** tab | Crossfade | Near a border, notes can also pick from the neighbouring zone. 50/50 right at the border, fading to 0 at the Crossfade distance. |
| **Zones** tab | Pool Zone selector | Chooses which zone Load folder / drops fill. |

Zones notes: **Low plays +12 semitones and High plays -12**, because bass sounds are usually recorded low and lead sounds high. An empty zone borrows from the nearest filled one, so you never get silence.

**MPE:** a normal pitch wheel bends all notes. With an MPE controller (or MPE pitch curves drawn in a clip's Note Expression), each note bends on its own. No setup needed.

**Saving:** your sample list, zones and per-sound settings are saved **with the Live set**. Samples are saved as **file paths**, not copied, so keep your sample folders where they are (and *Collect All and Save* will not gather them).

## Troubleshooting

| Problem | Try this |
|---|---|
| The device loads but is empty, greyed out, or you see "Max file not found" style errors | `multikey.voice.maxpat` or `multikey_loader.js` isn't next to `multiKey.amxd`. Load the device straight from the repo's `device/` folder, or add that folder via *Places > Add Folder*. |
| Dropping a folder or files does nothing | Drop onto the **waveform area** (top left), not the dropdown or buttons. If it still fails, use **Load folder**. If you got the repo as a ZIP, run the `xattr` command from Step 1. |
| No sound | Check that the track has MIDI input and is armed or monitoring. Check that sounds are loaded (the sample count shows next to the waveform). Is **Solo** on? Is the Volume knob low? |
| Notes are the wrong pitch | Your samples probably aren't in C. Use the global or per-sound Transpose. |
| Everything is quiet, or distorts on big chords | Lower the device Volume. Defaults leave about 10 dB of headroom, but dense chords of loud samples can still add up. |
| Per-note MPE bends don't arrive | Make sure the track receives MPE data (MPE controller, or a clip with Note Expression pitch curves). Report it if it still fails. |
| Sounds are missing after reopening a set | The samples were moved or renamed. Put them back or load them again. |
| Live crashes | See *Reporting a bug* below. v0.7 made loading much safer. If it still crashes when dropping many files, tell me exactly what you did. |

## Updating to a newer version

```bash
cd ~/Music/multiKey
git pull
```
Then **close Live and reopen it**, and drag the device in again (or reload your set). With GitHub Desktop: *Fetch origin*, then *Pull origin*. Re-download the ZIP if you used that.

## Reporting a bug

Please send:
1. **What you did** (for example "dragged 20 wav files onto the waveform while a clip was playing").
2. **Version**: the small label next to the *multiKey* title in the device (currently `v0.7`).
3. **Live version** and Mac model (Apple Silicon or Intel).
4. If Live crashed, the newest file from `~/Library/Logs/DiagnosticReports` (look for "Live" in the name), and `Log.txt` from `~/Library/Preferences/Ableton/Live 12.x.x/`.
5. If the device printed something: click the **Edit** button in the device's title bar (opens Max), then *Window > Max Console*, and copy any lines starting with `multiKey:`.

[docs/TESTING.md](docs/TESTING.md) has a checklist of things worth trying and what to report.

---

# About the project

## Status

**v0.7, early prototype.** Loading, drag and drop, zones, MPE, Preview and Solo are confirmed working in Live 12. The crash-safe loading in v0.7 and restoring samples on reopen are still being tested. See [CHANGELOG.md](CHANGELOG.md) for what changed in each version.

## What it does

- **Layout:** the sample list and a waveform of the selected sound on the left; on the right a **Global** tab (affects every sound), a **Sound** tab (Volume / Transpose, Solo for the selected sound) and a **Zones** tab.
- **Zones** (optional): separate sound pools for Low / Mid / High key ranges (Low +12 st, High -12 st), with a crossfade so neighbouring zones blend near the borders.
- **Sample pool:** drop a folder or files on the waveform, or use *Load folder* / *Add file*. The sample list is saved with your Live set.
- **Chromatic playback:** every sample is assumed to be a **C**. C3 (MIDI 60) plays it at its original pitch, and other notes transpose it.
- **A random pick per note:** each note draws its own sample, so a clicked-in chord no longer repeats one sample on every note.
- **Chord dealing:** notes that land within the *Chord window* (default 30 ms) are dealt different samples. A 4-note chord always gets 4 different one-shots if the pool has at least 4.
- **Seed:** picks are derived from the song position plus the seed value, so a clip plays the same on every playback and bounce. *Re-roll* gives a new set of picks.
- **Spread:** a random stereo position per note.
- **Pitch bend + MPE:** normal pitch wheel, and per-note bends with MPE (48 st, the MPE standard).
- **Global envelope:** attack, decay, sustain and release, plus *Vel > Vol* and a volume fader. 32 voices.
- **Preview and Solo** for auditioning the selected sound.

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

## Building (only if you want to change the device)

The patchers are generated from code, so every change is readable in git. You only need Python 3 (macOS has it after installing the Command Line Tools):

```
python3 tools/build_device.py
```

Edit `tools/build_device.py` (the wiring) or `device/multikey_loader.js` (loading), then rebuild and reload the device in Live. Don't hand-edit the generated `.maxpat`/`.amxd` files: the next build overwrites them.

## Sharing with friends

The three files in `device/` must stay together. Before sending the device out on its own, open it in Max and use **Freeze Device**, which bundles the voice patch and the script into the `.amxd`. Saved sample lists point to file paths on your machine, so friends need to load their own samples (shareable presets are on the roadmap).
