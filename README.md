# Superschedules IAC

This repository contains Terraform configuration for setting up the local development environment. The configuration installs required packages, clones several Git repositories, and performs basic setup for each project.

## Usage

1. Ensure [Terraform](https://developer.hashicorp.com/terraform/install) is installed locally.
2. Ensure you have an SSH key configured with access to GitHub.
3. Initialize and apply the configuration:

```sh
terraform init
terraform apply
```

Terraform will execute commands that:

- Update apt package information and install `rake`, `git`, `python3-pip`, `python3-venv`, `nodejs`, and `npm`.
- Verify that your SSH key can authenticate with GitHub.
- Clone the following repositories to your home directory using SSH:
  - [dotfiles-1](https://github.com/gkirkpatrick/dotfiles-1) and run `rake install` within it.
  - [superschedules](https://github.com/gkirkpatrick/superschedules), create a `schedules_dev` virtual environment, and install dependencies from `requirements.txt`.
  - [superschedules_IAC](https://github.com/gkirkpatrick/superschedules_IAC).
  - [superschedules_frontend](https://github.com/gkirkpatrick/superschedules_frontend) and install npm dependencies.

Each repository is cloned if it does not already exist. If it is already present, the configuration will run `git pull` to update it before performing the setup steps.
