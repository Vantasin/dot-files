# Package Index

## Stow Packages
- [../zsh/README.md](../zsh/README.md) — interactive zsh config and shared shell modules. Details: [zsh.md](zsh.md)
- [../git/README.md](../git/README.md) — global Git config. Details: [git.md](git.md)
- [../tmux/README.md](../tmux/README.md) — tmux config. Details: [tmux.md](tmux.md)
- [../ranger/README.md](../ranger/README.md) — ranger config. Details: [ranger.md](ranger.md)
- [../fastfetch/README.md](../fastfetch/README.md) — fastfetch config. Details: [fastfetch.md](fastfetch.md)
- [../btop/README.md](../btop/README.md) — btop config. Details: [btop.md](btop.md)
- [../bat/README.md](../bat/README.md) — bat config. Details: [bat.md](bat.md)
- [../ncdu/README.md](../ncdu/README.md) — ncdu config. Details: [ncdu.md](ncdu.md)
- [../nano/README.md](../nano/README.md) — nano config and syntax files. Details: [nano.md](nano.md)

## Support Directories
- [../bootstrap/README.md](../bootstrap/README.md) — optional package installation scripts. Details: [bootstrap.md](bootstrap.md)
- [../shell/README.md](../shell/README.md) — optional local login-shell examples. Details: [shell.md](shell.md)
- [../scripts/README.md](../scripts/README.md) — maintenance scripts tied to install and rollback workflows. Related: [makefile.md](makefile.md)

## Usage
- Apply all packages: `make stow`
- Preview links and conflicts: `make status`
- Remove all packages: `make unstow`
- Rename conflicts aside automatically: `make force-install`

## Notes
- Repo paths use `dot-*` names; Stow creates dotfiles in `$HOME`.
- Package `README.md` files are documentation only and are ignored by the Stow commands in `Makefile`.
- Internal docs should use relative Markdown links so packages, docs, and READMEs stay connected.
- Conflicts: Stow will refuse to overwrite; move or back up existing files before stowing, or use `make force-install`.
