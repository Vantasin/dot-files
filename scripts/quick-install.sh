#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/Vantasin/dot-files.git}"
CLONE_DIR="${CLONE_DIR:-$HOME/Git/dot-files}"
DRY_RUN="${DRY_RUN:-0}"
OS_NAME="${OS_NAME:-$(uname -s)}"

CLONE_DIR="${CLONE_DIR/#\~/$HOME}"

log() {
  printf '%s\n' "$*"
}

die() {
  printf '%s\n' "$*" >&2
  exit 1
}

show_cmd() {
  printf '+'
  while (($#)); do
    printf ' %q' "$1"
    shift
  done
  printf '\n'
}

run() {
  show_cmd "$@"
  if [[ "$DRY_RUN" != "1" ]]; then
    "$@"
  fi
}

ensure_macos_bootstrap() {
  if ! command -v brew >/dev/null 2>&1; then
    log "Homebrew not found; installing it first."
    if [[ "$DRY_RUN" == "1" ]]; then
      log '+ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  fi

  if [[ -x /opt/homebrew/bin/brew ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    if [[ "$DRY_RUN" != "1" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  elif [[ -x /usr/local/bin/brew ]]; then
    export PATH="/usr/local/bin:$PATH"
    if [[ "$DRY_RUN" != "1" ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  fi

  if [[ "$DRY_RUN" != "1" ]] && ! command -v brew >/dev/null 2>&1; then
    die "brew is required after Homebrew installation"
  fi
}

ensure_git_macos() {
  if ! command -v git >/dev/null 2>&1; then
    run brew install git
  fi
}

ensure_repo_prereqs_debian() {
  command -v apt-get >/dev/null 2>&1 || die "apt-get is required on Linux for quick-install.sh"

  local -a packages=()
  if ! command -v git >/dev/null 2>&1; then
    packages+=(git)
  fi
  if ! command -v make >/dev/null 2>&1; then
    packages+=(make)
  fi

  if [[ "${#packages[@]}" -gt 0 ]]; then
    local -a prefix=()
    if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
      command -v sudo >/dev/null 2>&1 || die "sudo is required when not running as root"
      prefix=(sudo)
    fi

    run "${prefix[@]}" apt-get update
    run "${prefix[@]}" apt-get install -y "${packages[@]}"
  fi
}

ensure_repo_clone() {
  if [[ -d "$CLONE_DIR/.git" ]]; then
    log "Repo already present at $CLONE_DIR"
    return
  fi

  if [[ -e "$CLONE_DIR" ]]; then
    die "Clone path exists and is not a git repo: $CLONE_DIR"
  fi

  run mkdir -p "$(dirname "$CLONE_DIR")"
  run git clone "$REPO_URL" "$CLONE_DIR"
}

run_repo_install() {
  if [[ "$DRY_RUN" == "1" ]]; then
    log "+ (cd $(printf '%q' "$CLONE_DIR") && make install)"
  else
    (
      cd "$CLONE_DIR"
      make install
    )
  fi
}

main() {
  case "$OS_NAME" in
    Darwin)
      ensure_macos_bootstrap
      ensure_git_macos
      ;;
    Linux)
      ensure_repo_prereqs_debian
      ;;
    *)
      die "Unsupported OS for quick-install.sh: $OS_NAME"
      ;;
  esac

  ensure_repo_clone
  run_repo_install
}

main "$@"
