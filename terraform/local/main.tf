terraform {
  required_version = ">= 0.12"
}

resource "null_resource" "setup_once" {
  provisioner "local-exec" {
    command     = <<EOT
sudo apt-get update
sudo apt-get install -y rake git python3-pip python3-venv curl build-essential
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
