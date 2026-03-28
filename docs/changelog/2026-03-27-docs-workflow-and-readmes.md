# 2026-03-27 Docs Workflow And READMEs

## Summary
- Added documentation rules and a workflow for maintaining READMEs and deeper docs.
- Tightened the repo root `README.md` into a quick start and navigation hub.
- Added top-level directory README files for packages and support directories.
- Updated Stow ignore behavior so package `README.md` files remain documentation only.
- Added documentation indexes for `docs/` and `docs/agents/`.

## Why
- The repo had only a root README, which made navigation harder once the docs started to grow.
- Package and support directories needed short local entrypoints so maintainers can orient themselves without reading every deep doc first.
- The root README should stay focused on onboarding and quick navigation instead of accumulating every operational detail.
- Package READMEs needed an explicit Stow ignore rule so they would not leak into `$HOME`.

## Verification
- Confirmed the new docs link structure uses relative Markdown links.
- Confirmed the root README now points to the docs hub, package index, and maintenance docs.
- Confirmed package and support directories now have local README entrypoints.
- Confirmed the Stow flags ignore package `README.md` files.

## Follow-up
- When package layout or docs structure changes, update the relevant directory README, the package index, and the root README if navigation changes.
