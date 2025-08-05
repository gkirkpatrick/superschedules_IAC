# Superschedules IAC

This repository contains Terraform configuration for the Superschedules project. The Terraform code lives under the `terraform/` directory and is organized into environments for development and production. The development configuration installs required packages, clones several Git repositories, and performs basic setup for each project.

## Usage

1. Ensure [Terraform](https://developer.hashicorp.com/terraform/install) is installed locally.
2. Ensure you have an SSH key configured with access to GitHub.
3. Change into the development configuration directory and initialize/apply:

```sh
cd terraform/dev
terraform init
terraform apply
```

Terraform runs two resources:

- **setup_once** updates apt package information and installs base packages: `rake`, `git`, `python3-pip`, `python3-venv`, `curl`, and `build-essential`. This runs only once unless the resource is tainted.
- **setup_environment** runs on every apply. It verifies that your SSH key can authenticate with GitHub, clones or updates repositories, installs Node.js 20 via NVM, and installs frontend dependencies.

The following repositories are cloned to your home directory using SSH:

- [dotfiles-1](https://github.com/gkirkpatrick/dotfiles-1) and run `rake install` within it.
- [superschedules](https://github.com/gkirkpatrick/superschedules), create a `schedules_dev` virtual environment, and install dependencies from `requirements.txt`.
- [superschedules_IAC](https://github.com/gkirkpatrick/superschedules_IAC).
- [superschedules_frontend](https://github.com/gkirkpatrick/superschedules_frontend) and install npm dependencies.

Each repository is cloned if it does not already exist. If it is already present, the configuration will run `git pull` to update it before performing the setup steps.
