#!/usr/bin/env bash
set -euo pipefail

# optional target directory
TARGET_DIR="${1:-.}"
cd "$TARGET_DIR"

# 0) install dev tools
if [[ "$(uname)" == "Darwin" ]]; then
  xcode-select -p >/dev/null 2>&1 || xcode-select --install || true
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null || echo true)"
else
  sudo apt-get update -y
  sudo apt-get install -y build-essential python3 make g++ curl ca-certificates
fi

# 1) install Node
if ! command -v node >/dev/null 2>&1; then
  if [[ "$(uname)" == "Darwin" ]] && command -v brew >/dev/null 2>&1; then
    brew install node@20
    export PATH="$(brew --prefix node@20)/bin:$PATH"
  else
    export NVM_DIR="$HOME/.nvm"
    mkdir -p "$NVM_DIR"
    if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
      curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    fi
    . "$NVM_DIR/nvm.sh"
    nvm install 20.19.0
    nvm use 20.19.0
  fi
fi

# 2) enable corepack and pin pnpm
corepack enable
corepack prepare pnpm@9.12.0 --activate

# 3) clean install dependencies
rm -rf node_modules
pnpm install

echo "Bootstrap complete. Node: $(node -v); pnpm: $(pnpm -v)"
