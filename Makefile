.PHONY: init plan apply destroy-plan destroy-apply

init:
	cd env && aws-vault exec wal -- terraform init

plan: 
	cd env && aws-vault exec wal -- terraform plan --var-file=dev.tfvars -out=dev.tfplan

apply: 
	cd env && aws-vault exec wal -- terraform apply dev.tfplan

destroy-plan: 
	cd env && aws-vault exec wal -- terraform plan -destroy --var-file=dev.tfvars -out=dev-destroy.tfplan

destroy-apply: 
	cd env && aws-vault exec wal -- terraform apply dev-destroy.tfplan