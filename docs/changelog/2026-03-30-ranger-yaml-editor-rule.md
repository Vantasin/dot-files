# Summary

- Added a repo-local `ranger` `rifle.conf` based on the packaged default rules.
- Treated `.yml` and `.yaml` as editable text so ranger sends them to `${VISUAL:-$EDITOR}` instead of macOS `open`.
- Updated the ranger package docs to document the new active config file and behavior.

# Why

- A partial `rifle.conf` would have replaced the packaged defaults entirely.
- On this macOS setup, Python MIME detection classifies YAML as `application/yaml`, which caused the default `open` rule to win before the generic editor fallback.

# Verification

- `rifle -c ranger/dot-config/ranger/rifle.conf -l /tmp/ranger-test.yml`
- `rifle -c ranger/dot-config/ranger/rifle.conf -l /tmp/ranger-test.txt`
- `make status`
