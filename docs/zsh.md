# Zsh Notes

## Layout & Flow
- `zsh/dot-zshenv` — minimal env; sets XDG paths; fast, non-interactive-safe; delegates interactivity to `.zshrc`.
- `zsh/dot-zshrc` — interactive: sources exports, creates cache (`~/.cache/zsh`) and state (`~/.local/state/zsh`) dirs, runs `compinit` with cached compdump, loads modules, then Antidote plugins, then optional fastfetch.
- `zsh/dot-config/shell/*.zsh` — loaded in order: `history` → `aliases` → `functions` → `keybinds` → `prompt`. History runs before plugins so autosuggestions see shared history.

## Plugins (Antidote)
- Installed at `~/.antidote`; plugin list in `~/.zsh_plugins.txt`.
- `.zshrc` sources Antidote then `antidote load < ~/.zsh_plugins.txt`.

## History
- Config lives only in `dot-config/shell/history.zsh`.
- `HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history`, `HISTSIZE/SAVEHIST=10000`.
- Options: `APPEND_HISTORY`, `INC_APPEND_HISTORY`, `SHARE_HISTORY`, `HIST_FCNTL_LOCK`, `HIST_IGNORE_DUPS`, `HIST_IGNORE_ALL_DUPS`, `HIST_REDUCE_BLANKS`.

## Prompt & VCS
- `prompt.zsh` uses `vcs_info`; hooks on `precmd` and `chpwd`; seeds once on startup; clears when outside a repo.
- Toggle git segment via `SKIP_VCS_INFO` (1/true/yes/on hides it; 0/empty/unset shows). Default is hidden (set in `exports.zsh`).

## Fastfetch
- `.zshrc` runs `fastfetch` once per interactive shell unless `SKIP_SYSINFO=1` or command missing.
- Uses `fastfetch` config from the stowed fastfetch package.

## Dirs & Caches
- Completion cache: `~/.cache/zsh/compdump`.
- History state: `~/.local/state/zsh/history` (created on demand).
- No `${XDG_DATA_HOME}/zsh` directory is created.
