#!/bin/bash
set -e
REPO_DIR="$HOME/superschedules_IAC"
if [ ! -d "$REPO_DIR" ]; then
  git clone git@github.com:gkirkpatrick/superschedules_IAC "$REPO_DIR"
else
  (cd "$REPO_DIR" && git pull)
fi
