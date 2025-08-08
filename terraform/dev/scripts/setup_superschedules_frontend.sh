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
nvm use 20

# Ensure Homebrew is available in login shells
if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"
  BREW_SHELLENV="eval \"\$(${BREW_PREFIX}/bin/brew shellenv)\""
  if ! grep -Fq "$BREW_SHELLENV" "$HOME/.zprofile" 2>/dev/null; then
    echo "$BREW_SHELLENV" >> "$HOME/.zprofile"
  fi
  eval "$(${BREW_PREFIX}/bin/brew shellenv)"
fi

# Ensure NVM is initialized for new shells
if ! grep -q 'export NVM_DIR="$HOME/.nvm"' "$HOME/.zshrc" 2>/dev/null; then
  cat >> "$HOME/.zshrc" <<'EOF'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
EOF
fi

# Install frontend dependencies
cd "$REPO_DIR"
npm install
