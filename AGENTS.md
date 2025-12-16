# Repository Guidelines

## Project Structure & Module Organization
- Root packages are Stow-ready directories: `zsh/`, `git/`, `tmux/`, `btop/`, `neofetch/`, `ranger/`, `bat/`, `nano/`, `ncdu/`. Each mirrors its target path (e.g., `zsh/.zshenv`, `btop/.config/btop/btop.conf`).
- `packages.stow` is the single source of truth for what to stow. `Makefile` wraps common tasks.
- `reference/` holds legacy or upstream copies (oh-my-zsh, nano syntax bundle, old configs); never deployed or edited for active use.
- `bootstrap/` contains optional OS package installers (`macos.sh`, `debian.sh`).

## Build, Test, and Development Commands
- Dry-run links: `make status` (or `stow -n -v --target="$HOME" $(cat packages.stow)`).
- Apply links: `make stow` (or `stow --target="$HOME" zsh git tmux btop neofetch ranger bat nano ncdu`).
- Remove links: `make unstow`.
- Install Antidote if missing: `make antidote` (clones to `~/.antidote`).
- Bootstrap packages (optional): `make macos` or `make debian`.

## Coding Style & Naming Conventions
- Shell scripts: bash (`set -euo pipefail`); 2-space indent preferred; keep commands explicit and portable.
- Zsh config: pure zsh + Antidote; plugins listed in `.zsh_plugins.txt`; prompt lives in `prompt.zsh`; no Oh-My-Zsh sourcing.
- Paths follow XDG: configs under `.config/<tool>/`; dotfiles (e.g., `.zshenv`, `.gitconfig`) at package root.

## Testing Guidelines
- No automated tests. Validate changes via `make status` to confirm Stow targets are clean and by opening a new shell to ensure zsh startup is fast and error-free.
- When modifying shell scripts, run `shellcheck` locally if available; otherwise, sanity-check with `bash -n`.

## Commit & Pull Request Guidelines
- Commits: concise, imperative subject line (e.g., “Add nano syntax includes to nanorc”). Group related changes; avoid mixing functional changes with refactors.
- PRs: include summary, rationale, and manual verification steps (e.g., `make status`, shell reload). Note any user-visible changes (new aliases, updated paths) and potential conflicts with existing `$HOME` files.

## Security & Configuration Tips
- Do not commit secrets or machine-specific paths. Keep system-level configs out of the repo.
- When adopting existing dotfiles with Stow, back up or use `stow --adopt` cautiously to avoid overwriting user data.***
