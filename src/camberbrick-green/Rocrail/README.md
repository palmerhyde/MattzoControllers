# Rocrail Workspaces

This directory holds the Camberbrick Green **Rocrail workspaces** under version control.

## What lives here

A Rocrail *workspace* is one layout's data directory. Each subdirectory here is a
self-contained workspace:

```
Rocrail/
  camberbrick-green/      ← the active layout
    plan.xml              ← the track plan (the layout itself)
    rocrail.ini           ← Rocrail server settings for this layout
    rocview.ini           ← RocView (GUI) view settings
    occ.xml               ← loco occupancy / positions
    camberbrick_green.xml ← older 2023 export, kept for history (not the active plan)
    images/               ← loco & layout images referenced by the plan
    decspecs/ stylesheets/ ← decoder specs & track stylesheets
```

Program resources (svg track symbols, the web UI, default decoder specs) are **not**
stored here — they ship inside `Rocrail.app` and are shared across all layouts.

## What git ignores

See [.gitignore](.gitignore). Runtime / regenerable files are not tracked:
`backup/` (auto-saved snapshots), `trace/` (logs), `*.bak`, and the `svg`/`web`
symlinks Rocrail recreates into the app bundle at runtime.

## How Rocrail opens it

RocView reads its startup config from `~/rocrail/rocview.ini` (on this case-insensitive
filesystem that is the same as `~/Rocrail`, RocView's default base directory). It is
configured to open this workspace automatically:

```xml
<gui ... defaultworkspace=".../Rocrail/camberbrick-green" startdefaultworkspace="true">
  <workspaces>
    <workspace path=".../Rocrail/camberbrick-green" title="Camberbrick Green"/>
  </workspaces>
```

Launching `Rocrail.app` opens the Camberbrick Green layout from this repo path.

The command station is `lib="virtual"` (no physical hardware required to open the
layout); Rocrail talks to the controllers over MQTT (`localhost:1883`).

## Adding another workspace

Create a new subdirectory here containing at least a `plan.xml` and `rocrail.ini`,
then add it via RocView (File ▸ Workspace ▸ Open Workspace) or as another
`<workspace>` entry in `~/rocrail/rocview.ini`.

## Restoring / backups

The pristine import from the old machine remains at `~/Downloads/rocrail/` (includes
the full `backup/` history). This repo copy is the working copy.
