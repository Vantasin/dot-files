SHELL := /bin/bash
OS := $(shell uname -s)
PACKAGES_FILE := packages.stow
PACKAGES := $(shell awk 'NF && $$1 !~ /^\043/' "$(PACKAGES_FILE)" 2>/dev/null)
STOW := stow
STOW_FLAGS := --dotfiles --ignore='(\.DS_Store|README\.md)$$' --target="$(HOME)"
BACKUP_ROOT := $(HOME)/.dotfiles_backup
TIMESTAMP := $(shell date +%Y%m%d-%H%M%S)
LOG_FILE ?= $(HOME)/.dotfiles_install.log

.PHONY: help check check-packages check-stow antidote stow unstow restow status force-install macos macos-complete verify-brewfile-complete refresh-brewfile-complete debian install install-complete uninstall backup list-backups restore restore-latest restore-prompt

help:
	@printf "Targets:\n"
	@printf "  help        Show this help message\n"
	@printf "  check       Verify required tools (git, stow, rsync) and package list\n"
	@printf "  status      Dry-run stow with verbose output\n"
	@printf "  antidote    Install Antidote to $$HOME/.antidote if missing\n"
	@printf "  stow        Stow all packages listed in %s\n" "$(PACKAGES_FILE)"
	@printf "  unstow      Unstow all packages listed in %s\n" "$(PACKAGES_FILE)"
	@printf "  restow      Restow all packages listed in %s\n" "$(PACKAGES_FILE)"
	@printf "  force-install Move conflicts to <path>.bak-%s then stow (logs to %s)\n" "$(TIMESTAMP)" "$(LOG_FILE)"
	@printf "  backup      Backup existing dotfiles to $(BACKUP_ROOT)/<timestamp>\n"
	@printf "  list-backups List available backups under $(BACKUP_ROOT)\n"
	@printf "  restore     Restore missing files from BACKUP=path (non-overwriting)\n"
	@printf "  restore-latest Restore missing files from the most recent backup\n"
	@printf "  restore-prompt Interactively choose a backup to restore\n"
	@printf "  install     Bootstrap missing tools if needed, backup, then stow dotfiles\n"
	@printf "  install-complete Bootstrap with Brewfile.complete, then backup and stow dotfiles\n"
	@printf "  uninstall   Unstow dotfiles; optionally call OS bootstrap uninstall\n"
	@printf "  macos       Run bootstrap/macos.sh with the given ACTION (install/uninstall)\n"
	@printf "  macos-complete Run bootstrap/macos.sh install with Brewfile.complete\n"
	@printf "  verify-brewfile-complete Compare Brewfile.complete to a fresh Homebrew Bundle dump\n"
	@printf "  refresh-brewfile-complete Rewrite Brewfile.complete from the current Mac state\n"
	@printf "  debian      Run bootstrap/debian.sh with the given ACTION (install/uninstall)\n"

check:
	@$(MAKE) check-packages
	@command -v git >/dev/null 2>&1 || { echo "git is required"; exit 1; }
	@command -v $(STOW) >/dev/null 2>&1 || { echo "stow is required"; exit 1; }
	@command -v rsync >/dev/null 2>&1 || { echo "rsync is required"; exit 1; }

check-packages:
	@test -n "$(PACKAGES)" || { echo "No packages listed in $(PACKAGES_FILE)"; exit 1; }

check-stow:
	@$(MAKE) check-packages
	@command -v $(STOW) >/dev/null 2>&1 || { echo "stow is required"; exit 1; }

antidote:
	@if [[ ! -d "$$HOME/.antidote" ]]; then \
		git clone --depth=1 https://github.com/mattmc3/antidote "$$HOME/.antidote"; \
	else \
		echo "Antidote already present at $$HOME/.antidote"; \
	fi

stow: check-stow
	$(STOW) $(STOW_FLAGS) $(PACKAGES)

unstow: check-stow
	$(STOW) -D $(STOW_FLAGS) $(PACKAGES)

restow: check-stow
	$(STOW) -R $(STOW_FLAGS) $(PACKAGES)

status: check-stow
	$(STOW) -nv $(STOW_FLAGS) $(PACKAGES)

force-install: check-stow
	@set -euo pipefail; \
	LOG_FILE="$(LOG_FILE)"; \
	log(){ ts="$$(date +%Y-%m-%dT%H:%M:%S%z)"; msg="$$ts $$*"; echo "$$msg"; if [[ -n "$$LOG_FILE" ]]; then echo "$$msg" >>"$$LOG_FILE"; fi; }; \
	log "Starting force-install (log: $$LOG_FILE)"; \
	tmp="$$(mktemp)"; \
	trap 'rm -f "$$tmp"' EXIT; \
	log "Checking for conflicts with stow dry-run..."; \
	if $(STOW) -nv $(STOW_FLAGS) $(PACKAGES) >"$$tmp" 2>&1; then \
		log "No conflicts detected; applying stow."; \
		$(STOW) $(STOW_FLAGS) $(PACKAGES); \
		log "Force-install complete (no conflicts)."; \
		exit 0; \
	fi; \
	conflicts="$$(awk '/existing target/ { \
		line = $$0; \
		if (line ~ /over existing target[[:space:]]+/) { \
			sub(/^.*over existing target[[:space:]]+/, "", line); \
			sub(/[[:space:]].*$$/, "", line); \
			print line; \
			next; \
		} \
		if (line ~ /existing target[^:]*: /) { \
			sub(/^.*existing target[^:]*: /, "", line); \
			sub(/[[:space:]].*$$/, "", line); \
			print line; \
		} \
	}' "$$tmp" | sort -u)"; \
	if [[ -z "$$conflicts" ]]; then \
		log "Stow reported conflicts but none could be parsed; output follows:"; \
		cat "$$tmp"; \
		exit 1; \
	fi; \
	printf "%s\n" "$$conflicts" | while IFS= read -r rel; do \
		[[ -n "$$rel" ]] || continue; \
		src="$(HOME)/$$rel"; \
		dest="$$src.bak-$(TIMESTAMP)"; \
		if [[ -e "$$src" || -L "$$src" ]]; then \
			log "Moving $$src -> $$dest"; \
			mv "$$src" "$$dest"; \
		fi; \
	done; \
	log "Re-running stow now that conflicts are moved..."; \
	$(STOW) $(STOW_FLAGS) $(PACKAGES); \
	log "Force-install complete."

macos:
	@if [[ -x "bootstrap/macos.sh" ]]; then \
		ACTION="$${ACTION:-install}"; \
		bootstrap/macos.sh "$$ACTION"; \
	else \
		echo "bootstrap/macos.sh not found or not executable"; \
	fi

macos-complete:
	@$(MAKE) macos ACTION=install BREWFILE=Brewfile.complete

verify-brewfile-complete:
	@set -euo pipefail; \
	if [[ "$(OS)" != "Darwin" ]]; then \
	  echo "verify-brewfile-complete is supported on macOS only"; \
	  exit 1; \
	fi; \
	command -v brew >/dev/null 2>&1 || { echo "brew is required"; exit 1; }; \
	test -f Brewfile.complete || { echo "Brewfile.complete not found"; exit 1; }; \
	dump="$$(mktemp -t Brewfile.complete.dump)"; \
	expected="$$(mktemp -t Brewfile.complete.check)"; \
	trap 'rm -f "$$dump" "$$expected"' EXIT; \
	write_header(){ \
	  printf "%s\n" \
	    "# Full Homebrew Bundle snapshot for this Mac." \
	    "# Generated by: make refresh-brewfile-complete" \
	    "#" \
	    "# Verify against the current installed Homebrew state:" \
	    "#   make verify-brewfile-complete" \
	    "#" \
	    "# Regenerate after intentional package changes:" \
	    "#   make refresh-brewfile-complete" \
	    "#" \
	    '# This file is not the default `make install` bootstrap manifest.' \
	    "# It records the complete Homebrew state of the development machine." \
	    "#" \
	    "# Homebrew verification command:" \
	    "#   brew bundle check --no-upgrade --file=Brewfile.complete" \
	    ""; \
	}; \
	brew bundle dump --file="$$dump" --force >/dev/null; \
	{ write_header; cat "$$dump"; } >"$$expected"; \
	if diff -u Brewfile.complete "$$expected"; then \
	  echo "Brewfile.complete matches the current machine state."; \
	else \
	  echo "Brewfile.complete differs from the current machine state."; \
	  exit 1; \
	fi

refresh-brewfile-complete:
	@set -euo pipefail; \
	if [[ "$(OS)" != "Darwin" ]]; then \
	  echo "refresh-brewfile-complete is supported on macOS only"; \
	  exit 1; \
	fi; \
	command -v brew >/dev/null 2>&1 || { echo "brew is required"; exit 1; }; \
	test -f Brewfile.complete || { echo "Brewfile.complete not found"; exit 1; }; \
	tmp="$$(mktemp -t Brewfile.complete.refresh)"; \
	trap 'rm -f "$$tmp"' EXIT; \
	write_header(){ \
	  printf "%s\n" \
	    "# Full Homebrew Bundle snapshot for this Mac." \
	    "# Generated by: make refresh-brewfile-complete" \
	    "#" \
	    "# Verify against the current installed Homebrew state:" \
	    "#   make verify-brewfile-complete" \
	    "#" \
	    "# Regenerate after intentional package changes:" \
	    "#   make refresh-brewfile-complete" \
	    "#" \
	    '# This file is not the default `make install` bootstrap manifest.' \
	    "# It records the complete Homebrew state of the development machine." \
	    "#" \
	    "# Homebrew verification command:" \
	    "#   brew bundle check --no-upgrade --file=Brewfile.complete" \
	    ""; \
	}; \
	brew bundle dump --file="$$tmp" --force >/dev/null; \
	{ write_header; cat "$$tmp"; } >Brewfile.complete; \
	echo "Refreshed Brewfile.complete from the current machine state."; \
	echo "Review git diff before committing."

debian:
	@if [[ -x "bootstrap/debian.sh" ]]; then \
		ACTION="$${ACTION:-install}"; \
		bootstrap/debian.sh "$$ACTION"; \
	else \
		echo "bootstrap/debian.sh not found or not executable"; \
	fi

backup:
	@set -euo pipefail; \
	BACKUP_DIR="$(BACKUP_ROOT)/$(TIMESTAMP)"; \
	if [[ -e "$$BACKUP_DIR" ]]; then echo "Backup directory already exists: $$BACKUP_DIR"; exit 1; fi; \
	mkdir -p "$$BACKUP_DIR"; \
	files=( \
	  .zshrc .zshenv .zsh_plugins.txt .tmux.conf .gitconfig \
	  .config/shell .config/git .config/ranger .config/fastfetch \
	  .config/btop .config/bat .config/nano .config/ncdu \
	); \
	repo_root="$$(pwd)"; \
	cd "$$HOME"; \
	for f in "$${files[@]}"; do \
	  if [[ -e "$$f" ]]; then \
	    if [[ -L "$$f" ]]; then \
	      target="$$(perl -MCwd=abs_path -e 'my $$p = shift; my $$a = abs_path($$p); exit 1 unless defined $$a; print $$a' "$$f")"; \
	      case "$$target" in $$repo_root/*) echo "Skipping symlink into repo: $$HOME/$$f"; continue ;; esac; \
	    fi; \
	    rsync -a --relative "$$f" "$$BACKUP_DIR/"; \
	  fi; \
	done; \
	echo "Backup created at $$BACKUP_DIR"

list-backups:
	@set -euo pipefail; \
	if [[ ! -d "$(BACKUP_ROOT)" ]]; then \
	  echo "No backups found under $(BACKUP_ROOT)"; \
	  exit 0; \
	fi; \
	backups="$$(find "$(BACKUP_ROOT)" -mindepth 1 -maxdepth 1 -type d -print | LC_ALL=C sort)"; \
	if [[ -z "$$backups" ]]; then \
	  echo "No backups found under $(BACKUP_ROOT)"; \
	  exit 0; \
	fi; \
	printf "%s\n" "$$backups"

restore:
	@set -euo pipefail; \
	if [[ -z "$${BACKUP:-}" ]]; then \
	  echo "Usage: make restore BACKUP=$$HOME/.dotfiles_backup/<timestamp>"; \
	  echo "Available backups:"; \
	  $(MAKE) list-backups; \
	  exit 1; \
	fi; \
	BACKUP_PATH="$${BACKUP/#\~/$HOME}"; \
	if [[ ! -d "$$BACKUP_PATH" ]]; then echo "Backup not found: $$BACKUP_PATH"; exit 1; fi; \
	if command -v rsync >/dev/null 2>&1; then \
	  rsync -av --ignore-existing "$$BACKUP_PATH"/ "$$HOME"/; \
	else \
	  echo "rsync not found; falling back to cp"; \
	  find "$$BACKUP_PATH" -mindepth 1 -print | LC_ALL=C sort | while IFS= read -r src; do \
	    rel="$${src#$$BACKUP_PATH/}"; \
	    dest="$$HOME/$$rel"; \
	    if [[ -e "$$dest" || -L "$$dest" ]]; then \
	      continue; \
	    fi; \
	    mkdir -p "$$(dirname "$$dest")"; \
	    cp -RPp "$$src" "$$dest"; \
	  done; \
	fi

restore-latest:
	@set -euo pipefail; \
	if [[ ! -d "$(BACKUP_ROOT)" ]]; then \
	  echo "No backups found under $(BACKUP_ROOT)"; \
	  exit 1; \
	fi; \
	latest="$$(find "$(BACKUP_ROOT)" -mindepth 1 -maxdepth 1 -type d -print | LC_ALL=C sort | tail -n 1)"; \
	if [[ -z "$$latest" ]]; then \
	  echo "No backups found under $(BACKUP_ROOT)"; \
	  exit 1; \
	fi; \
	echo "Restoring latest backup: $$latest"; \
	$(MAKE) restore BACKUP="$$latest"

restore-prompt:
	@set -euo pipefail; \
	if [[ ! -d "$(BACKUP_ROOT)" ]]; then \
	  echo "No backups found under $(BACKUP_ROOT)"; \
	  exit 1; \
	fi; \
	backups=(); \
	while IFS= read -r backup; do \
	  backups+=("$$backup"); \
	done < <(find "$(BACKUP_ROOT)" -mindepth 1 -maxdepth 1 -type d -print | LC_ALL=C sort); \
	if [[ "$${#backups[@]}" -eq 0 ]]; then \
	  echo "No backups found under $(BACKUP_ROOT)"; \
	  exit 1; \
	fi; \
	echo "Available backups:"; \
	for i in "$${!backups[@]}"; do \
	  printf "  %d. %s\n" "$$((i + 1))" "$${backups[$$i]}"; \
	done; \
	while true; do \
	  printf "Choose backup number to restore (press Enter to cancel): "; \
	  IFS= read -r choice; \
	  if [[ -z "$$choice" ]]; then \
	    echo "Restore canceled."; \
	    exit 0; \
	  fi; \
	  if [[ "$$choice" =~ ^[0-9]+$$ ]] && (( choice >= 1 && choice <= $${#backups[@]} )); then \
	    selected="$${backups[$$((choice - 1))]}"; \
	    echo "Restoring backup: $$selected"; \
	    $(MAKE) restore BACKUP="$$selected"; \
	    exit 0; \
	  fi; \
	  echo "Invalid selection: $$choice"; \
	done

install:
	@set -euo pipefail; \
	LOG_FILE="$(LOG_FILE)"; \
	log(){ ts="$$(date +%Y-%m-%dT%H:%M:%S%z)"; msg="$$ts $$*"; echo "$$msg"; if [[ -n "$$LOG_FILE" ]]; then echo "$$msg" >>"$$LOG_FILE"; fi; }; \
	bootstrap_ran=0; \
	log "Starting install (log: $$LOG_FILE)"; \
	log "Validating package list"; $(MAKE) check-packages; \
	if ! command -v git >/dev/null 2>&1 || ! command -v $(STOW) >/dev/null 2>&1 || ! command -v rsync >/dev/null 2>&1; then \
		if [[ "$(OS)" == "Darwin" ]]; then \
			log "Missing install prerequisites (git, stow, rsync); running macOS bootstrap install before continuing"; \
			$(MAKE) macos ACTION=install; \
			bootstrap_ran=1; \
		elif [[ "$(OS)" == "Linux" ]]; then \
			log "Missing install prerequisites (git, stow, rsync); running Debian bootstrap install before continuing"; \
			$(MAKE) debian ACTION=install; \
			bootstrap_ran=1; \
		else \
			log "Install prerequisites missing and no bootstrap script for OS=$(OS)"; \
			exit 1; \
		fi; \
	fi; \
	log "Running check"; $(MAKE) check; \
	log "Running status (dry-run stow)"; \
	if $(MAKE) status; then \
		log "Status completed without conflicts"; \
	else \
		log "Install aborted: stow dry-run reported conflicts. Resolve them manually or run 'make force-install'."; \
		exit 1; \
	fi; \
	log "Backing up existing files"; $(MAKE) backup; \
	if [[ "$$bootstrap_ran" -eq 1 ]]; then \
	  log "Bootstrap install already ran earlier to restore missing prerequisites"; \
	elif [[ "$(OS)" == "Darwin" ]]; then \
	  log "Running macOS bootstrap install"; \
	  $(MAKE) macos ACTION=install; \
	elif [[ "$(OS)" == "Linux" ]]; then \
	  log "Running Debian bootstrap install"; \
	  $(MAKE) debian ACTION=install; \
	else \
	  log "No bootstrap script for OS=$(OS)"; \
	fi; \
	log "Ensuring Antidote is installed"; $(MAKE) antidote; \
	log "Stowing packages"; $(MAKE) stow; \
	log "Install complete"

install-complete:
	@$(MAKE) install BREWFILE=Brewfile.complete

uninstall:
	$(MAKE) unstow
	@if [[ "$(OS)" == "Darwin" ]]; then \
	  $(MAKE) macos ACTION=uninstall; \
	elif [[ "$(OS)" == "Linux" ]]; then \
	  $(MAKE) debian ACTION=uninstall; \
	else \
	  echo "No bootstrap script for OS=$(OS)"; \
	fi
