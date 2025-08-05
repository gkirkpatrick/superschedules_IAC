# Superschedules IAC

This repository contains Terraform configuration for setting up the local development environment. The configuration installs required packages and clones several Git repositories.

## Usage

1. Ensure [Terraform](https://developer.hashicorp.com/terraform/install) is installed locally.
2. Ensure you have an SSH key configured with access to GitHub.
3. Initialize and apply the configuration:

```sh
terraform init
terraform apply
```

Terraform will execute commands that:

- Update apt package information and install `rake` and `git`.
- Verify that your SSH key can authenticate with GitHub.
- Clone the following repositories to your home directory using SSH:
  - [dotfiles-1](https://github.com/gkirkpatrick/dotfiles-1)
  - [superschedules](https://github.com/gkirkpatrick/superschedules)
  - [superschedules_IAC](https://github.com/gkirkpatrick/superschedules_IAC)
  - [superschedules_frontend](https://github.com/gkirkpatrick/superschedules_frontend)

Each repository is cloned if it does not already exist. If it is already present, the configuration will run `git pull` to update it.
