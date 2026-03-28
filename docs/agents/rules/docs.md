# Docs Rules

## Structure
- The repo root [README.md](../../README.md) should stay focused on quick start, summary, and links to deeper docs.
- Top-level package and support directories should have a concise `README.md`.
- Detailed operational behavior belongs in `docs/*.md`, not in every directory README.
- [../../docs/packages.md](../../docs/packages.md) is the package index.
- [../../docs/README.md](../../docs/README.md) is the documentation hub.

## README Expectations
- Keep README files concise and navigational.
- Package README files should describe purpose, main stow targets or key files, and link to the deeper docs for that package.
- Support-directory README files should explain what the directory is for and point to the governing workflow or reference docs.
- Avoid copying the same long explanation into multiple README files.
- Package `README.md` files are documentation only and must stay ignored by the Stow commands in `Makefile`.

## Linking
- Use relative Markdown links for internal references.
- Prefer linking to the nearest useful entrypoint: package README for navigation, `docs/*.md` for deep detail, root README for quick start.
- When a doc mentions a package or support directory that has a README, link to it where that helps navigation.

## Update Triggers
- If install or stow behavior changes, update [../../README.md](../../README.md) and the relevant docs such as [../../docs/makefile.md](../../docs/makefile.md).
- If a package layout or purpose changes, update that directory's `README.md` and [../../docs/packages.md](../../docs/packages.md).
- If agent workflows or maintenance expectations change, update `docs/agents/`.
- If agent docs or indexes change materially, run the agent-config review workflow.
