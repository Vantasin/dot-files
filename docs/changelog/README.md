# Changelog Notes

This directory holds short human-readable audit entries for significant repo changes.

## Why It Exists
- Git already stores the exact diff and history.
- These notes capture the higher-level operational context: what changed, why it mattered, and how it was verified.
- They are meant for meaningful change sets, not as a log line for every small edit.

## Naming
- Use `YYYY-MM-DD-short-title.md`.

## Include An Entry When
- install, stow, backup, restore, or bootstrap behavior changes
- package layout or active package list changes
- shell startup behavior changes
- agent workflows or maintenance rules change in ways that affect future work

## Skip An Entry When
- the change is formatting-only
- the change is a typo fix with no behavioral impact
- the change is an obvious internal cleanup with no maintenance impact

## Timing
- Prefer writing or updating the entry near commit time or handoff time, once the change set is coherent.
