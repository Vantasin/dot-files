# Docs Maintenance Workflow

## Goal
- Keep README files useful as navigation and keep deeper behavior in the docs where it can be maintained centrally.
- Apply this workflow to meaningful documentation changes, not every intermediate draft edit.

## Update Flow
1. Decide whether the change affects quick start, package layout, behavior, or maintenance workflow.
2. If quick start or repo navigation changed, update [../../README.md](../../README.md).
3. If a top-level package or support directory changed, update that directory's `README.md`.
4. If the change affects behavior or operational detail, update the relevant `docs/*.md`.
5. If the change affects maintenance rules or workflows, update `docs/agents/`.
6. If the change is meaningful, add an entry under [../../docs/changelog/](../../docs/changelog/README.md).
7. If the change touches `AGENTS.md`, `docs/agents/`, or doc indexes, run the agent-config review workflow.

## What Goes Where
- Root `README.md`: quick start, summary, high-level links.
- Directory `README.md`: purpose, main files or stow targets, and links to deeper docs.
- `docs/*.md`: detailed reference material, behavior, caveats, and workflow specifics.
- `docs/agents/*.md`: maintenance guidance for future contributors and agents.

## Linking And Consistency
- Use relative Markdown links between READMEs and docs.
- Keep package names and commands consistent with `packages.stow` and `Makefile`.
- When adding a new package directory, add its README and wire it into [../../docs/packages.md](../../docs/packages.md).
- If a package directory gets a `README.md`, confirm the Stow ignore pattern still excludes it from installation.
- If docs and behavior disagree, resolve that drift in the same change set instead of leaving it for later.

## Verification
- Open changed Markdown files and verify the links and paths make sense.
- Confirm commands still match current repo behavior.
- If package layout, install behavior, or workflow changed, update the corresponding changelog entry or add a new one for the overall change set.
