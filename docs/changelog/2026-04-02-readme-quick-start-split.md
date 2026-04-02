# 2026-04-02 README Quick Start Split

## Summary
- Moved the explicit macOS and Debian/Ubuntu install steps out of the root `README.md` into a dedicated [../manual-install.md](../manual-install.md) guide.
- Repositioned the curl-based convenience installer as the primary quick-start path in the root README.
- Updated the docs index and scripts README to link to the new manual install guide.

## Why
- The root README should stay optimized for quick onboarding and high-signal navigation.
- The explicit setup path is still valuable, but it is easier to maintain in one dedicated install guide than alongside the convenience installer in the same section.

## Verification
- Opened the changed Markdown files and checked the new internal links.
- Confirmed the manual install commands still match the current install prerequisites and canonical clone path.
