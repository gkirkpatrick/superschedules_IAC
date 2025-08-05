#!/bin/bash
set -e
REPO_DIR="$HOME/superschedules"
if [ ! -d "$REPO_DIR" ]; then
  git clone git@github.com:gkirkpatrick/superschedules "$REPO_DIR"
else
  (cd "$REPO_DIR" && git pull)
fi
if [ ! -d "$REPO_DIR/schedules_dev" ]; then
  python3 -m venv "$REPO_DIR/schedules_dev"
fi
source "$REPO_DIR/schedules_dev/bin/activate"
pip install -r "$REPO_DIR/requirements.txt"
deactivate
