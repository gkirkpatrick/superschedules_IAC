terraform {
  required_version = ">= 0.12"
}

resource "null_resource" "setup_once" {
  provisioner "local-exec" {
    command     = <<EOT
if [[ "$(uname)" == "Darwin" ]]; then
  # Ensure Homebrew is installed
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew" >&2
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$($(test -x /opt/homebrew/bin/brew && echo /opt/homebrew/bin/brew || echo /usr/local/bin/brew) shellenv)"
  fi
  brew update
  brew install git curl python postgresql
  brew services start postgresql
  
  # Create database and user for superschedules
  createdb superschedules 2>/dev/null || true
  createuser superschedules 2>/dev/null || true
else
  sudo apt-get update
  sudo apt-get install -y git python3-pip python3-venv python-is-python3 curl build-essential postgresql postgresql-contrib postgresql-16-pgvector
  sudo systemctl start postgresql
  sudo systemctl enable postgresql
  
  # Create database and user for superschedules
  sudo -u postgres createdb superschedules 2>/dev/null || true
  sudo -u postgres createuser --superuser $USER 2>/dev/null || true
  sudo -u postgres createuser superschedules 2>/dev/null || true
  sudo -u postgres psql -c "ALTER USER superschedules CREATEDB;" 2>/dev/null || true
  
  # Install pgvector extension in template databases so it's available for all new databases
  sudo -u postgres psql -d template1 -c "CREATE EXTENSION IF NOT EXISTS vector;" 2>/dev/null || true
  sudo -u postgres psql -d superschedules -c "CREATE EXTENSION IF NOT EXISTS vector;" 2>/dev/null || true
fi

  # Install Ollama if not already installed
  if ! command -v ollama >/dev/null 2>&1; then
    curl -fsSL https://ollama.com/install.sh | sh
  fi

  # Show existing Ollama models
  echo "Existing Ollama models:"
  ollama list || true

  # Download Gemma2 model only if missing
  if ! ollama list 2>/dev/null | grep -q '^gemma2'; then
    ollama pull gemma2:latest
  fi
EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "setup_environment" {
  provisioner "local-exec" {
    command     = <<EOT
# Verify GitHub SSH access
if ! ssh -o StrictHostKeyChecking=no -o BatchMode=yes -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
  echo "Error: could not authenticate to GitHub via SSH." >&2
  exit 1
fi

${path.module}/../dev/scripts/setup_dotfiles.sh
${path.module}/../dev/scripts/setup_superschedules.sh
${path.module}/../dev/scripts/setup_superschedules_IAC.sh
${path.module}/../dev/scripts/setup_superschedules_frontend.sh
${path.module}/../dev/scripts/setup_superschedules_collector.sh
${path.module}/../dev/scripts/setup_superschedules_navigator.sh
EOT
    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [
    null_resource.setup_once
  ]
}
