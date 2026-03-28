# Changelog Rules

## Purpose
- Git remains the source of truth for exact diffs and authorship.
- `docs/changelog/` is for short human-readable audit notes: what changed, why it changed, and how it was verified.

## When To Add An Entry
- Add an entry for meaningful behavioral changes, workflow changes, safety fixes, package additions or removals, or documentation restructures that affect maintenance.
- Do not add an entry for trivial typo fixes, formatting-only edits, or low-signal internal cleanup.
- Do not create one changelog entry per tiny edit; prefer one entry for a coherent change set, usually near commit or handoff time.

## Format
- One Markdown file per meaningful change set.
- Use `YYYY-MM-DD-short-title.md`.
- Keep entries brief and factual.

## Recommended Sections
- `Summary`
- `Why`
- `Verification`
- `Follow-up` if needed

## Scope
- Prefer one entry for a coherent set of related changes rather than one file per commit.
- Link to the relevant docs or files when useful, but do not duplicate whole diffs from git.
