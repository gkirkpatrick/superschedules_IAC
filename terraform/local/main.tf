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
  brew install git curl python
else
  sudo apt-get update
  sudo apt-get install -y git python3-pip python3-venv curl build-essential
fi

  # Install Ollama and the Gemma2 model (gemma2:latest)
  curl -fsSL https://ollama.com/install.sh | sh
  ollama pull gemma2:latest
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
