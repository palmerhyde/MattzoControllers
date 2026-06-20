#!/usr/bin/env python3
"""Sync a local markdown mirror of the Mattzobricks Build & Automation docs.

- Crawl-based discovery (seeded from /build and /automation) so new pages are
  found automatically, plus any pages already recorded in the manifest.
- Change detection by hashing the extracted document body. Unchanged pages are
  left untouched on disk (no spurious git/Obsidian churn).
- When a page changes, the new version is written AND a dated report is produced
  in "Sync Reports/" containing a unified diff of what changed.

Usage:
    python sync.py [--vault PATH] [--baseline] [--no-discover]
                   [--timeout SEC] [--delay SEC] [--max-pages N]

--baseline  : write/refresh all pages and rebuild the manifest WITHOUT emitting
              a change report. Use once to establish the known-good baseline.
"""
import argparse
import datetime
import difflib
import hashlib
import json
import os
import re
import sys
import time
from collections import deque
from urllib.parse import urldefrag, urljoin, urlparse

import requests
from bs4 import BeautifulSoup
from markdownify import markdownify as md

BASE = "https://mattzobricks.com"
SEEDS = ["build", "automation"]
ALLOWED_PREFIXES = ("build", "automation")
HEADERS = {"User-Agent": "MattzoDocsArchiver/1.0 (personal offline mirror)"}
SKIP_EXT = (".jpg", ".jpeg", ".png", ".gif", ".webp", ".svg", ".pdf", ".zip",
            ".mp4", ".webm", ".ico", ".css", ".js", ".xml", ".json")
DEFAULT_VAULT = "src/camberbrick-green/Mattzobricks Documentation"
MAX_DIFF_LINES = 3000

FM_RE = re.compile(r"^---\n.*?\n---\n+", re.S)


def norm_path(href):
    """Normalise an href into a site-relative doc path, or None if out of scope."""
    if not href:
        return None
    href, _ = urldefrag(href)
    p = urlparse(urljoin(BASE + "/", href))
    if p.netloc and p.netloc not in ("mattzobricks.com", "www.mattzobricks.com"):
        return None
    path = p.path.strip("/")
    if not path:
        return None
    low = path.lower()
    if low.endswith(SKIP_EXT):
        return None
    if any(seg in low for seg in ("wp-content", "wp-admin", "wp-json", "wp-login")):
        return None
    if path.split("/")[0] not in ALLOWED_PREFIXES:
        return None
    return path


def extract(html, path):
    """Return (title, body_markdown, discovered_paths, canonical_path)."""
    soup = BeautifulSoup(html, "html.parser")
    content = (soup.select_one("article .entry-content")
               or soup.select_one("main")
               or soup.body)

    canon = None
    link = soup.select_one('link[rel="canonical"]')
    if link and link.get("href"):
        canon = norm_path(link["href"])

    h1 = soup.select_one("article h1, h1.entry-title, h1")
    title = (h1.get_text(strip=True) if h1
             else path.split("/")[-1].replace("-", " ").title())

    for tag in content.select(
            "script, style, .sharedaddy, .jp-relatedposts, nav, .post-navigation"):
        tag.decompose()
    for img in content.find_all("img"):
        if "lazy_placeholder" in (img.get("src") or ""):
            img.decompose()

    body = md(str(content), heading_style="ATX", strip=["span"]).strip()
    body = re.sub(r"\n{3,}", "\n\n", body)

    discovered = set()
    for a in soup.find_all("a", href=True):
        np = norm_path(a["href"])
        if np:
            discovered.add(np)

    return title, body, discovered, canon


def doc_body(title, body):
    return f"# {title}\n\n{body}\n"


def frontmatter(title, url, scraped):
    return (f'---\ntitle: "{title.replace(chr(34), chr(39))}"\n'
            f"source: {url}\nscraped: {scraped}\n---\n\n")


def strip_fm(text):
    return FM_RE.sub("", text, count=1)


def make_diff(old, new, path):
    lines = list(difflib.unified_diff(
        old.splitlines(), new.splitlines(),
        fromfile=f"previous/{path}", tofile=f"current/{path}", lineterm=""))
    if len(lines) > MAX_DIFF_LINES:
        lines = lines[:MAX_DIFF_LINES] + [
            f"... (diff truncated at {MAX_DIFF_LINES} lines) ..."]
    return "\n".join(lines)


def load_manifest(path):
    if os.path.exists(path):
        try:
            return json.load(open(path, encoding="utf-8"))
        except (json.JSONDecodeError, OSError):
            pass
    return {"version": 1, "last_sync": None, "pages": {}, "runs": []}


def rel(target, start):
    return os.path.relpath(target, start).replace(os.sep, "/")


def build_root_index(vault, manifest):
    """(Re)write the vault's README.md: a hierarchical index of all pages."""
    entries = manifest["pages"]
    L = ["# Mattzobricks Documentation (local mirror)", "",
         "Local markdown copies of the [Mattzobricks](https://mattzobricks.com) "
         "**Build** and **Automation** documentation, kept current by the "
         "`sync-mattzobricks-docs` skill. Each file keeps its source URL in the "
         "frontmatter; images are referenced from the live site.", "",
         f"_Last synced: {manifest.get('last_sync', '?')} — {len(entries)} pages. "
         "Change history: [Sync Reports](<Sync Reports/README.md>)._", ""]
    for section in ("build", "automation"):
        L += [f"## {section.title()}", ""]
        paths = sorted(p for p in entries
                       if p == section or p.startswith(section + "/"))
        for p in paths:
            indent = "  " * p.count("/")
            title = entries[p].get("title", p.split("/")[-1])
            L.append(f"{indent}- [{title}]({p}.md)")
        L.append("")
    open(os.path.join(vault, "README.md"), "w", encoding="utf-8").write(
        "\n".join(L) + "\n")


def write_report(vault, results, run, baseline):
    reports_dir = os.path.join(vault, "Sync Reports")
    os.makedirs(reports_dir, exist_ok=True)
    changed = bool(results["added"] or results["updated"] or results["removed"])

    report_name = None
    if changed and not baseline:
        report_name = run["report"]
        fpath = os.path.join(reports_dir, report_name)
        L = [f"# Sync report — {run['stamp']}", "",
             f"- **Added:** {len(results['added'])}",
             f"- **Updated:** {len(results['updated'])}",
             f"- **Removed:** {len(results['removed'])}",
             f"- **Unchanged:** {run['unchanged']}",
             f"- **Errors:** {len(results['errors'])}", ""]
        if results["added"]:
            L += ["## Added pages", ""]
            for a in results["added"]:
                link = rel(os.path.join(vault, a["path"] + ".md"), reports_dir)
                L.append(f"- [{a['title']}]({link}) — `{a['path']}.md`")
            L.append("")
        if results["updated"]:
            L += ["## Updated pages", ""]
            for u in results["updated"]:
                link = rel(os.path.join(vault, u["path"] + ".md"), reports_dir)
                L += [f"### {u['title']}",
                      f"[{u['path']}.md]({link}) — source: {BASE}/{u['path']}",
                      "", "```diff", u["diff"], "```", ""]
        if results["removed"]:
            L += ["## Removed pages",
                  "_No longer published; local copies archived to `.sync/archive/`._",
                  ""]
            for p in results["removed"]:
                L.append(f"- `{p}`")
            L.append("")
        if results["errors"]:
            L += ["## Errors", ""]
            for p, e in results["errors"]:
                L.append(f"- `{p}` — {e}")
            L.append("")
        open(fpath, "w", encoding="utf-8").write("\n".join(L) + "\n")

    # Rebuild the running index from manifest run history.
    idx = os.path.join(reports_dir, "README.md")
    H = ["# Sync Reports", "",
         "Running log of documentation sync runs (newest first). "
         "Generated by the `sync-mattzobricks-docs` skill.", "",
         "| When | Added | Updated | Removed | Unchanged | Report |",
         "|---|---|---|---|---|---|"]
    return reports_dir, idx, H, report_name


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--vault", default=DEFAULT_VAULT)
    ap.add_argument("--baseline", action="store_true")
    ap.add_argument("--no-discover", action="store_true")
    ap.add_argument("--timeout", type=int, default=30)
    ap.add_argument("--delay", type=float, default=0.4)
    ap.add_argument("--max-pages", type=int, default=400)
    args = ap.parse_args()

    vault = os.path.abspath(args.vault)
    if not os.path.isdir(vault):
        sys.exit(f"Vault folder not found: {vault}")

    sync_dir = os.path.join(vault, ".sync")
    os.makedirs(sync_dir, exist_ok=True)
    manifest_path = os.path.join(sync_dir, "manifest.json")
    manifest = load_manifest(manifest_path)

    now = datetime.datetime.now()
    today = now.date().isoformat()
    stamp = now.strftime("%Y-%m-%d %H:%M")

    session = requests.Session()
    session.headers.update(HEADERS)

    queue, seen = deque(), set()
    for p in SEEDS + list(manifest["pages"].keys()):
        if p not in seen:
            seen.add(p)
            queue.append(p)

    results = {"added": [], "updated": [], "removed": [], "errors": []}
    unchanged = 0
    processed = 0
    aliases = 0

    while queue and processed < args.max_pages:
        path = queue.popleft()
        url = f"{BASE}/{path}"
        try:
            r = session.get(url, timeout=args.timeout)
        except requests.RequestException as e:
            results["errors"].append((path, str(e)))
            continue

        if r.status_code in (404, 410):
            if path in manifest["pages"]:
                dest = os.path.join(vault, path + ".md")
                if os.path.exists(dest):
                    arch = os.path.join(sync_dir, "archive", path + ".md")
                    os.makedirs(os.path.dirname(arch), exist_ok=True)
                    os.replace(dest, arch)
                manifest["pages"].pop(path, None)
                results["removed"].append(path)
            continue
        if r.status_code != 200:
            results["errors"].append((path, f"HTTP {r.status_code}"))
            continue

        title, body, discovered, canon = extract(r.text, path)
        if not args.no_discover:
            for d in discovered:
                if d not in seen:
                    seen.add(d)
                    queue.append(d)

        # The site serves identical content under several URL paths. Follow the
        # page's declared canonical URL and skip non-canonical aliases so the
        # mirror has exactly one file per real page.
        if canon and canon != path:
            if canon not in seen:
                seen.add(canon)
                queue.append(canon)
            aliases += 1
            continue
        processed += 1

        new_doc = doc_body(title, body)
        new_hash = hashlib.sha256(new_doc.encode("utf-8")).hexdigest()
        dest = os.path.join(vault, path + ".md")
        old_doc = (strip_fm(open(dest, encoding="utf-8").read())
                   if os.path.exists(dest) else None)

        entry = manifest["pages"].get(path, {})
        entry.update({"url": url, "title": title, "hash": new_hash,
                      "last_checked": today})
        entry.setdefault("first_seen", today)

        if old_doc is None:
            os.makedirs(os.path.dirname(dest), exist_ok=True)
            open(dest, "w", encoding="utf-8").write(
                frontmatter(title, url, today) + new_doc)
            entry["last_changed"] = today
            if baseline_unchanged := args.baseline:
                unchanged += 1
            else:
                results["added"].append({"path": path, "title": title})
        elif old_doc.rstrip("\n") != new_doc.rstrip("\n"):
            open(dest, "w", encoding="utf-8").write(
                frontmatter(title, url, today) + new_doc)
            entry["last_changed"] = today
            if args.baseline:
                unchanged += 1
            else:
                results["updated"].append({
                    "path": path, "title": title,
                    "diff": make_diff(old_doc, new_doc, path)})
        else:
            unchanged += 1

        manifest["pages"][path] = entry
        time.sleep(args.delay)

    # Record this run.
    run = {
        "stamp": stamp,
        "added": len(results["added"]),
        "updated": len(results["updated"]),
        "removed": len(results["removed"]),
        "unchanged": unchanged,
        "errors": len(results["errors"]),
        "report": now.strftime("%Y-%m-%d_%H%M") + ".md",
        "baseline": bool(args.baseline),
    }
    reports_dir, idx, H, report_name = write_report(vault, results, run, args.baseline)
    run["report"] = report_name  # None if no report written
    manifest["runs"].append(run)
    manifest["last_sync"] = stamp

    # Rebuild Sync Reports/README.md from full run history.
    rows = []
    for rrun in reversed(manifest["runs"]):
        label = "baseline" if rrun.get("baseline") else (
            f"[{rrun['report']}]({rrun['report']})" if rrun.get("report")
            else "— (no changes)")
        rows.append(f"| {rrun['stamp']} | {rrun['added']} | {rrun['updated']} "
                    f"| {rrun['removed']} | {rrun['unchanged']} | {label} |")
    open(idx, "w", encoding="utf-8").write("\n".join(H + rows) + "\n")

    build_root_index(vault, manifest)
    json.dump(manifest, open(manifest_path, "w", encoding="utf-8"), indent=2)

    mode = "BASELINE" if args.baseline else "SYNC"
    print(f"[{mode}] {stamp}")
    print(f"  checked : {processed} pages ({aliases} aliases skipped)")
    print(f"  added   : {len(results['added'])}")
    print(f"  updated : {len(results['updated'])}")
    print(f"  removed : {len(results['removed'])}")
    print(f"  unchanged: {unchanged}")
    if results["errors"]:
        print(f"  errors  : {len(results['errors'])}")
        for p, e in results["errors"]:
            print(f"    - {p}: {e}")
    if report_name:
        print(f"  report  : Sync Reports/{report_name}")
    elif not args.baseline:
        print("  report  : (no changes — index updated only)")


if __name__ == "__main__":
    main()
