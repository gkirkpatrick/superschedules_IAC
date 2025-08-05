terraform {
  required_version = ">= 0.12"
}

resource "null_resource" "setup_environment" {
  provisioner "local-exec" {
    command     = <<EOT
sudo apt-get update
sudo apt-get install -y rake git

# Verify GitHub SSH access
if ! ssh -o StrictHostKeyChecking=no -o BatchMode=yes -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
  echo "Error: could not authenticate to GitHub via SSH." >&2
  exit 1
fi

# Clone dotfiles repository
if [ ! -d "$HOME/dotfiles-1" ]; then
  git clone git@github.com:gkirkpatrick/dotfiles-1 "$HOME/dotfiles-1"
else
  (cd "$HOME/dotfiles-1" && git pull)
fi

# Clone superschedules repositories
if [ ! -d "$HOME/superschedules" ]; then
  git clone git@github.com:gkirkpatrick/superschedules "$HOME/superschedules"
else
  (cd "$HOME/superschedules" && git pull)
fi

if [ ! -d "$HOME/superschedules_IAC" ]; then
  git clone git@github.com:gkirkpatrick/superschedules_IAC "$HOME/superschedules_IAC"
else
  (cd "$HOME/superschedules_IAC" && git pull)
fi

if [ ! -d "$HOME/superschedules_frontend" ]; then
  git clone git@github.com:gkirkpatrick/superschedules_frontend "$HOME/superschedules_frontend"
else
  (cd "$HOME/superschedules_frontend" && git pull)
fi
EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
