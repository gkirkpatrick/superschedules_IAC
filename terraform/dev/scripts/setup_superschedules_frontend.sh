#!/bin/bash
set -e
REPO_DIR="$HOME/superschedules_frontend"
if [ ! -d "$REPO_DIR" ]; then
  git clone git@github.com:gkirkpatrick/superschedules_frontend "$REPO_DIR"
else
  (cd "$REPO_DIR" && git pull)
fi

# Install NVM and Node.js 20
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install 20
nvm alias default 20

# Install frontend dependencies
cd "$REPO_DIR"
npm install
