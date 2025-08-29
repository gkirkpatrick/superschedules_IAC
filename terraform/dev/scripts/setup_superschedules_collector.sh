#!/bin/bash
set -e
REPO_DIR="$HOME/superschedules_collector"
if [ ! -d "$REPO_DIR" ]; then
  git clone git@github.com:gkirkpatrick/superschedules_collector "$REPO_DIR"
else
  (cd "$REPO_DIR" && git pull)
fi
if [ ! -d "$REPO_DIR/.venv" ]; then
  python3 -m venv "$REPO_DIR/.venv" --prompt "superschedules_collector"
fi
source "$REPO_DIR/.venv/bin/activate"
pip install -r "$REPO_DIR/requirements.txt"
deactivate
