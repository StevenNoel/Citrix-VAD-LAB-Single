#!/bin/bash
cd "/mnt/c/users/username/scripts/Automation/CitrixLab/Citrix-VAD-LAB-single-2203" #CHANGE
export TF_STATE=./terraform
terraform init
cd terraform
terraform destroy --auto-approve --var-file="lab.tfvars"