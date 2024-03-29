.PHONY: init plan apply destroy-plan destroy-apply apply-admin

init:
	cd env && aws-vault exec wal -- terraform init

plan: 
	cd env && aws-vault exec wal -- terraform plan --var-file=dev.tfvars -out=dev.tfplan

apply: 
	cd env && aws-vault exec wal -- terraform apply dev.tfplan

destroy-plan: 
	cd env && aws-vault exec wal --no-session -- terraform plan -destroy --var-file=dev.tfvars -out=dev-destroy.tfplan

destroy-apply: 
	cd env && aws-vault exec wal --no-session -- terraform apply dev-destroy.tfplan

plan-admin: 
	cd env && aws-vault exec wal --no-session -- terraform plan --var-file=dev.tfvars -out=dev.tfplan

apply-admin:
	cd env && aws-vault exec wal --no-session -- terraform apply "dev.tfplan"