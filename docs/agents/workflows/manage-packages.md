# Package Lifecycle Workflow

Use this workflow when adding, removing, renaming, or materially repurposing a Stow package.

## Add A Package
1. Create the top-level package directory with Stow-compatible layout.
2. Add the package name to `packages.stow`.
3. Add a concise package `README.md`.
4. Update `docs/packages.md` and any deeper package docs in `docs/*.md`.
5. If the package affects onboarding or install expectations, update the root `README.md`.
6. Run `make status`.

## Remove A Package
1. Remove the package from `packages.stow`.
2. Remove or archive the top-level package directory as appropriate.
3. Remove or update the package entry in `docs/packages.md`.
4. Remove or update related package docs and README links.
5. Run `make status`.

## Rename A Package
1. Rename the top-level package directory.
2. Update the corresponding entry in `packages.stow`.
3. Update package README links, `docs/packages.md`, and any deeper docs that reference the old name.
4. Run `make status`.

## Repurpose A Package
- If a package keeps the same name but changes scope, update its `README.md`, any deeper package docs, and the root `README.md` if onboarding expectations changed.
- Review the package against the structure, docs, and verification rules.

## Finish
- Use the verification matrix in [verify-by-change-type.md](verify-by-change-type.md).
- Add a changelog entry for meaningful package lifecycle changes.
