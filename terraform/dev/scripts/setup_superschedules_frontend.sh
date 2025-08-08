#!/bin/bash
set -euo pipefail

REPO_DIR="$HOME/superschedules_frontend"
if [ ! -d "$REPO_DIR" ]; then
  git clone git@github.com:gkirkpatrick/superschedules_frontend "$REPO_DIR"
else
  (cd "$REPO_DIR" && git pull)
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
"$ROOT_DIR/scripts/bootstrap.sh" "$REPO_DIR"
