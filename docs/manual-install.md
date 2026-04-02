# Manual Install

Use this path if you want to review each step before running it or debug a failed setup more easily than with the convenience installer.

## macOS
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
brew install git
git clone https://github.com/Vantasin/dot-files.git ~/Git/dot-files
cd ~/Git/dot-files && make install
```

## Debian/Ubuntu
```sh
sudo apt-get update && sudo apt-get install -y git make
git clone https://github.com/Vantasin/dot-files.git ~/Git/dot-files
cd ~/Git/dot-files && make install
```
> Use sudo only if required for package installs.

## Notes
- The manual commands above install only what is needed to clone the repo and invoke `make install`; the repo bootstrap then installs the managed toolchain.
- `make install` validates the package list, bootstraps missing `git`/`stow`/`rsync` if needed, then runs `check` → `status` (dry-run) → `backup` → bootstrap (if it did not already run) → antidote → stow.
- If the dry-run reports conflicts, install stops before backup and refuses to overwrite anything.
- On macOS, the bootstrap package set comes from the repo root [../Brewfile](../Brewfile) via `brew bundle`.
- For a broader machine restore snapshot, use [../Brewfile.complete](../Brewfile.complete) intentionally instead of making it the default bootstrap manifest.
- The repo does not install `~/.profile` or `~/.zprofile` by default.
- Keep login-shell files local to each machine; see [../shell/README.md](../shell/README.md) for optional examples.
- The canonical clone path in these docs is `~/Git/dot-files`.
- After `make uninstall`, `make install` can restore the missing toolchain again as long as the underlying package manager (`brew` or `apt`) is still available.
