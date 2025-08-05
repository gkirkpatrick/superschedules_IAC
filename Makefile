.PHONY: dev-ec2 dev-local prod-deploy

dev-ec2:
	terraform -chdir=terraform/dev init
	terraform -chdir=terraform/dev apply

dev-local:
	terraform -chdir=terraform/local init
	terraform -chdir=terraform/local apply

prod-deploy:
	terraform -chdir=terraform/prod init
	terraform -chdir=terraform/prod apply
