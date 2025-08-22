#!/bin/bash
set -e

if [[ "${1:-}" != "--install-dot-files" ]]; then
  echo "Dotfile installation skipped. Pass --install-dot-files to enable." >&2
  exit 0
fi

REPO_DIR="$HOME/dotfiles-1"
if [ ! -d "$REPO_DIR" ]; then
  git clone git@github.com:gkirkpatrick/dotfiles-1 "$REPO_DIR"
else
  (cd "$REPO_DIR" && git pull)
fi
(cd "$REPO_DIR" && ./install.sh)
