# Fastfetch Notes

## Location
- Config is stowed to `~/.config/fastfetch/config.jsonc` from `fastfetch/dot-config/fastfetch/`.

## Modules Shown
- Title, OS, Host, Kernel, Uptime, Packages, Shell, Terminal, CPU, GPU, Memory.
- Disk modules: individual entries for `/`, `/home`, `/tank` with `showRemovable/showUnknown` enabled.
- Local IP.

## Customizing
- Edit the `folders` array per disk entry to match your mounts; remove entries you do not want.
- If a mount is absent, Fastfetch will stat the directory on whatever filesystem is mounted there.
- No other dependencies; runs only if the `fastfetch` binary is present.

