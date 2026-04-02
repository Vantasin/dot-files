# 2026-04-02 btop Config Refresh

## Summary
- Refreshed the tracked `btop.conf` from the older `btop` 1.2.x format to the current 1.4.6-written format.
- Kept the existing overall layout and theme choices while accepting the newer option set and boolean formatting.

## Why
- Running a newer `btop` rewrites the config with updated comments, lowercase booleans, and new supported settings.
- Keeping the tracked config aligned with the version currently in use avoids repeated local churn and makes the repo reflect the real active defaults.

## Verification
- Reviewed the resulting config diff and confirmed it is a version-format refresh plus the newer supported options written by `btop`.
