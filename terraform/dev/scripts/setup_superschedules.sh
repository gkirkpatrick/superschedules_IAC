#!/bin/bash
set -e
REPO_DIR="$HOME/superschedules"
if [ ! -d "$REPO_DIR" ]; then
  git clone git@github.com:gkirkpatrick/superschedules "$REPO_DIR"
else
  (cd "$REPO_DIR" && git pull)
fi
if [ ! -d "$REPO_DIR/.venv" ]; then
  python -m venv "$REPO_DIR/.venv" --prompt "superschedules"
fi
source "$REPO_DIR/.venv/bin/activate"
pip install -r "$REPO_DIR/requirements.txt"

# Run database migrations to keep the schema up to date
python "$REPO_DIR/manage.py" migrate
deactivate
