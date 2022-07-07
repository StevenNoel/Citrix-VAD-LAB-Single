#!/bin/bash
#I'm Using Windows SubSystem for Linux
cd "/mnt/c/users/username/scripts/Automation/CitrixLab/Citrix-VAD-LAB-single-2203"
export TF_STATE=./terraform
cd terraform
terraform init
terraform apply --auto-approve --var-file="lab.tfvars"
sleep 60s
cd ..
#Sync
#Make sure to download Terraform-inventory (linux) and copy to /usr/bin
ansible-playbook --inventory-file=/usr/bin/terraform-inventory ./ansible/playbook.yml -e @./ansible/vars.yml