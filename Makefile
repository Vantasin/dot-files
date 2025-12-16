SHELL := /bin/bash
OS := $(shell uname -s)
PACKAGES_FILE := packages.stow
PACKAGES != [ -f $(PACKAGES_FILE) ] && awk 'NF && $$1 !~ /^#/' $(PACKAGES_FILE)
STOW := stow
STOW_FLAGS := --dotfiles --target="$(HOME)"
BACKUP_ROOT := $(HOME)/.dotfiles_backup
TIMESTAMP := $(shell date +%Y%m%d-%H%M%S)

.PHONY: help check antidote stow unstow restow status macos debian install uninstall backup restore

help:
	@printf "Targets:\n"
	@printf "  help        Show this help message\n"
	@printf "  check       Verify required tools (git, stow, rsync) and package list\n"
	@printf "  status      Dry-run stow with verbose output\n"
	@printf "  antidote    Install Antidote to $$HOME/.antidote if missing\n"
	@printf "  stow        Stow all packages listed in %s\n" "$(PACKAGES_FILE)"
	@printf "  unstow      Unstow all packages listed in %s\n" "$(PACKAGES_FILE)"
	@printf "  restow      Restow all packages listed in %s\n" "$(PACKAGES_FILE)"
	@printf "  backup      Backup existing dotfiles to $(BACKUP_ROOT)/<timestamp>\n"
	@printf "  restore     Restore missing files from BACKUP=path (non-overwriting)\n"
	@printf "  install     Bootstrap tools, backup, then stow dotfiles\n"
	@printf "  uninstall   Unstow dotfiles; optionally call OS bootstrap uninstall\n"
	@printf "  macos       Run bootstrap/macos.sh with the given ACTION (install/uninstall)\n"
	@printf "  debian      Run bootstrap/debian.sh with the given ACTION (install/uninstall)\n"

check:
	@command -v git >/dev/null 2>&1 || { echo "git is required"; exit 1; }
	@command -v $(STOW) >/dev/null 2>&1 || { echo "stow is required"; exit 1; }
	@command -v rsync >/dev/null 2>&1 || { echo "rsync is required"; exit 1; }
	@test -n "$(PACKAGES)" || { echo "No packages listed in $(PACKAGES_FILE)"; exit 1; }

antidote:
	@if [[ ! -d "$$HOME/.antidote" ]]; then \
		git clone --depth=1 https://github.com/mattmc3/antidote "$$HOME/.antidote"; \
	else \
		echo "Antidote already present at $$HOME/.antidote"; \
	fi

stow: check
	$(STOW) $(STOW_FLAGS) $(PACKAGES)

unstow: check
	$(STOW) -D $(STOW_FLAGS) $(PACKAGES)

restow: check
	$(STOW) -R $(STOW_FLAGS) $(PACKAGES)

status: check
	$(STOW) -nv $(STOW_FLAGS) $(PACKAGES)

macos:
	@if [[ -x "bootstrap/macos.sh" ]]; then \
		ACTION="$${ACTION:-install}"; \
		bootstrap/macos.sh "$$ACTION"; \
	else \
		echo "bootstrap/macos.sh not found or not executable"; \
	fi

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
	  .zshrc .zshenv .zprofile .zlogin .zlogout \
	  .gitconfig .tmux.conf .zsh_plugins.txt .nanorc \
	  .config/btop .config/neofetch .config/ranger .config/bat \
	  .config/nano .config/ncdu \
	); \
	repo_root="$$(pwd)"; \
	cd "$$HOME"; \
	for f in "$${files[@]}"; do \
	  if [[ -e "$$f" ]]; then \
	    if [[ -L "$$f" ]]; then \
	      target="$$(readlink -f "$$f")"; \
	      case "$$target" in $$repo_root/*) echo "Skipping symlink into repo: $$HOME/$$f"; continue ;; esac; \
	    fi; \
	    rsync -a --relative "$$f" "$$BACKUP_DIR/"; \
	  fi; \
	done; \
	echo "Backup created at $$BACKUP_DIR"

restore:
	@set -euo pipefail; \
	if [[ -z "$${BACKUP:-}" ]]; then \
	  echo "Usage: make restore BACKUP=$$HOME/.dotfiles_backup/<timestamp>"; \
	  echo "Available backups:"; ls -1 "$(BACKUP_ROOT)" 2>/dev/null || true; \
	  exit 1; \
	fi; \
	BACKUP_PATH="$${BACKUP/#\~/$HOME}"; \
	if [[ ! -d "$$BACKUP_PATH" ]]; then echo "Backup not found: $$BACKUP_PATH"; exit 1; fi; \
	rsync -av --ignore-existing "$$BACKUP_PATH"/ "$$HOME"/

install:
	$(MAKE) check
	-$(MAKE) status
	$(MAKE) backup
	@if [[ "$(OS)" == "Darwin" ]]; then \
	  $(MAKE) macos ACTION=install; \
	elif [[ "$(OS)" == "Linux" ]]; then \
	  $(MAKE) debian ACTION=install; \
	else \
	  echo "No bootstrap script for OS=$(OS)"; \
	fi
	$(MAKE) antidote
	$(MAKE) stow

uninstall:
	$(MAKE) unstow
	@if [[ "$(OS)" == "Darwin" ]]; then \
	  $(MAKE) macos ACTION=uninstall; \
	elif [[ "$(OS)" == "Linux" ]]; then \
	  $(MAKE) debian ACTION=uninstall; \
	else \
	  echo "No bootstrap script for OS=$(OS)"; \
	fi
