---
name: sync-mattzobricks-docs
description: Sync the local markdown mirror of the Mattzobricks Build & Automation documentation. Crawls mattzobricks.com, only re-downloads pages whose content changed, and writes a dated diff report so you can see exactly what Matt updated. Use when the user asks to sync/refresh/update the Mattzobricks docs, check for documentation changes, or pull the latest Mattzobricks docs.
---

# Sync Mattzobricks Documentation

Keeps a local Obsidian-friendly markdown mirror of the Mattzobricks
documentation (the **Build** and **Automation** sections of
https://mattzobricks.com) up to date, and reports what changed.

The mirror lives in **`src/camberbrick-green/Mattzobricks Documentation/`**.

## How it works

The bundled `sync.py`:

1. **Discovers pages** by crawling, seeded from `/build` and `/automation` plus
   every page already recorded in the manifest. New pages Matt publishes are
   found automatically.
2. **Detects changes** by extracting each page's body (same conversion the
   original mirror used) and comparing it to the copy on disk. Unchanged pages
   are left completely untouched — no needless git/Obsidian churn.
3. **Reports changes**: when a page is added or its content changed, the new
   markdown is written and a dated report appears in `Sync Reports/` with a
   unified diff. `Sync Reports/README.md` is a running log of every run.
4. **Handles removals**: pages that 404 are archived under `.sync/archive/` and
   noted in the report.

State lives in `.sync/manifest.json` (hashes, timestamps, run history) inside
the vault. The `.sync/` folder is hidden from Obsidian.

## Running it

All commands run from the repository root. Use the skill's own venv so nothing
is installed system-wide.

**1. Ensure the environment exists (first run only, or after deps change):**

```bash
VENV=".claude/skills/sync-mattzobricks-docs/.venv"
if [ ! -x "$VENV/bin/python" ]; then
  python3 -m venv "$VENV"
  "$VENV/bin/pip" install -q -r .claude/skills/sync-mattzobricks-docs/requirements.txt
fi
```

**2. Run the sync** (default `--vault` already points at the mirror):

```bash
.claude/skills/sync-mattzobricks-docs/.venv/bin/python \
  .claude/skills/sync-mattzobricks-docs/sync.py
```

The script runs for ~30–60s (it crawls ~60 pages with a polite delay) — run it
in the background and report the printed summary when it finishes.

## After running

- Read the printed summary (added / updated / removed / unchanged counts).
- If anything changed, open the newest report in `Sync Reports/` and give the
  user a short plain-English summary of **what Matt changed** (don't just dump
  the diff). Link the report and the affected pages.
- If nothing changed, just tell the user the mirror is already current.

## Options (pass after the script path)

- `--baseline` — write/refresh everything and rebuild the manifest WITHOUT a
  change report. Only needed to (re)establish the known-good baseline; normal
  syncs do not use this.
- `--vault PATH` — point at a different mirror folder.
- `--no-discover` — only re-check pages already in the manifest (skip crawling
  for new ones). Faster; misses newly published pages.
- `--delay SEC` (default 0.4), `--timeout SEC` (default 30),
  `--max-pages N` (default 400).

## Notes

- Images are referenced from the live site, not downloaded.
- The venv (`.venv`) and `.sync/` state are git-ignored.
