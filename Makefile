.PHONY: dev-ec2 dev-local prod-deploy

INSTALL_DOTFILES ?= false

dev-ec2:
        terraform -chdir=terraform/dev init
        terraform -chdir=terraform/dev apply -var "install_dotfiles=$(INSTALL_DOTFILES)"

dev-local:
        terraform -chdir=terraform/local init
        terraform -chdir=terraform/local apply -var "install_dotfiles=$(INSTALL_DOTFILES)"

prod-deploy:
        terraform -chdir=terraform/prod init
        terraform -chdir=terraform/prod apply
