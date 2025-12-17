#!/bin/bash
set -euo pipefail

# Roll back the most recent (or Nth most recent) make force-install move operations.
# Usage: LOG_FILE=~/.dotfiles_install.log RUN_INDEX=1 DRY_RUN=0 scripts/rollback-force-install.sh

LOG_FILE="${LOG_FILE:-$HOME/.dotfiles_install.log}"
RUN_INDEX="${RUN_INDEX:-1}" # 1 = latest force-install block, 2 = second-latest, etc.
DRY_RUN="${DRY_RUN:-0}"

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Log file not found: $LOG_FILE"
  exit 1
fi

if ! [[ "$RUN_INDEX" =~ ^[0-9]+$ ]] || [[ "$RUN_INDEX" -lt 1 ]]; then
  echo "RUN_INDEX must be a positive integer (got: $RUN_INDEX)"
  exit 1
fi

mapfile -t start_lines < <(grep -n "Starting force-install" "$LOG_FILE" | cut -d: -f1)
if [[ "${#start_lines[@]}" -eq 0 ]]; then
  echo "No force-install runs found in $LOG_FILE"
  exit 1
fi

if [[ "$RUN_INDEX" -gt "${#start_lines[@]}" ]]; then
  echo "Requested RUN_INDEX=$RUN_INDEX but only ${#start_lines[@]} force-install runs are in the log"
  exit 1
fi

start_line="${start_lines[@]: -$RUN_INDEX:1}"
moves=$(tail -n +"$start_line" "$LOG_FILE" | awk '/ Moving /{print $(NF-2) "\t" $(NF)}')

if [[ -z "$moves" ]]; then
  echo "No move entries found for the selected force-install run (starting at line $start_line)."
  exit 1
fi

echo "Using log: $LOG_FILE"
echo "Selected run index: $RUN_INDEX (line $start_line)"
echo "Planned restores:"
printf '%s\n' "$moves" | sed 's/\t/ <- /g'

if [[ "$DRY_RUN" == "1" ]]; then
  echo "DRY_RUN=1 set; no changes made."
  exit 0
fi

printf '%s\n' "$moves" | while IFS=$'\t' read -r src dest; do
  if [[ ! -e "$dest" && ! -L "$dest" ]]; then
    echo "Skipping $src (backup missing at $dest)"
    continue
  fi
  if [[ -e "$src" || -L "$src" ]]; then
    echo "Skipping $src (already exists; move or remove it first)"
    continue
  fi
  echo "Restoring $src from $dest"
  mv "$dest" "$src"
done

echo "Rollback complete."
