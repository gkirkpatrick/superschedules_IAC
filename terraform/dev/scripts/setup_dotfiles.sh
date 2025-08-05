#!/bin/bash
set -e
REPO_DIR="$HOME/dotfiles-1"
if [ ! -d "$REPO_DIR" ]; then
  git clone git@github.com:gkirkpatrick/dotfiles-1 "$REPO_DIR"
else
  (cd "$REPO_DIR" && git pull)
fi
(cd "$REPO_DIR" && rake install)
