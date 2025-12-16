# dot-files — Stow-managed, Antidote-powered dotfiles

- Minimal, auditable dotfiles using GNU Stow for symlinks and pure Zsh with Antidote for plugins.
- For users who want explicit, reversible, XDG-friendly configs on macOS or Debian-based Linux.
- Manages user-space configs only: zsh, git, tmux, ranger, fastfetch, btop, bat, ncdu, nano. No system services.
- Stow handles placement; Antidote handles plugins; package managers (or bootstrap scripts) handle binaries.

## Quick Start (copy/paste)
macOS:
```sh
brew install git stow rsync
git clone https://github.com/Vantasin/dot-files.git ~/dot-files
cd ~/dot-files && make install
```

Debian/Ubuntu:
```sh
sudo apt-get update && sudo apt-get install -y git stow rsync
git clone https://github.com/Vantasin/dot-files.git ~/dot-files
cd ~/dot-files && make install
```
> Use sudo only if required for package installs

> What `make install` does: check → status (dry-run) → backup → bootstrap (packages) → antidote → stow. It will refuse on conflicts rather than overwrite.

> If you already have a real `~/.profile`, back it up or move it aside before stowing the `shell` package; Stow will not overwrite an existing file.

Reload Shell:
```sh
exec zsh
```
> Verify: `ls -l ~/.zshrc` points into `~/dot-files`

Rollback:
```sh
cd ~/dot-files
make unstow
```
> Or: `stow -D --dotfiles --target="$HOME" zsh git tmux btop fastfetch ranger bat nano ncdu`

Backup:
```sh
cd ~/dot-files
make backup
```

Restore:
```sh
cd ~/dot-files
make restore BACKUP=~/.dotfiles_backup/<timestamp>
```

## More Details
- Makefile: see [docs/makefile.md](docs/makefile.md) (targets, backup/restore, stow flow).
- Zsh setup: see [docs/zsh.md](docs/zsh.md) (layout, history, Antidote, prompt toggle).
- Fastfetch: see [docs/fastfetch.md](docs/fastfetch.md).
- Packages overview: see [docs/packages.md](docs/packages.md).
- Bootstrap scripts: see [docs/bootstrap.md](docs/bootstrap.md).
- Other components: see docs for git, tmux, ranger, bat, btop, ncdu, nano, shell.

## License
[LICENSE](LICENSE)
