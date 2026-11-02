# Terraform Multi-Cloud Infrastructure Automation

**Portfolio starter implementation** demonstrating **three independently deployable cloud network foundations** in Microsoft Azure, AWS and GCP using reusable Terraform modules.

```text
stacks/
├── azure/ -> modules/azure-network -> Azure Resource Group, VNet, subnet
├── aws/   -> modules/aws-network   -> AWS VPC, private subnet
└── gcp/   -> modules/gcp-network   -> GCP VPC, regional subnetwork
```

Each stack has its **own state** and authentication. This example does not connect the clouds or implement VPN/transit gateways. It uses no compute VMs and intentionally exposes no inbound public workload access.

## Requirements
Terraform >= 1.6 and appropriate cloud CLI permissions. Sign in only to the cloud you want to deploy.

### Azure
```powershell
az login
cd stacks/azure
Copy-Item terraform.tfvars.example terraform.tfvars
# edit subscription_id
terraform init
terraform fmt -check
terraform validate
terraform plan -out=deploy.tfplan
terraform apply deploy.tfplan
```

### AWS
```powershell
aws configure sso
aws sso login --profile <YOUR_PROFILE>
$env:AWS_PROFILE='<YOUR_PROFILE>'
cd stacks/aws
terraform init
terraform validate
terraform plan -out=deploy.tfplan
terraform apply deploy.tfplan
```

### Google Cloud
```powershell
gcloud auth application-default login
gcloud config set project YOUR_GCP_PROJECT_ID
cd stacks/gcp
Copy-Item terraform.tfvars.example terraform.tfvars
# edit project_id and verify billing + API enablement
terraform init
terraform validate
terraform plan -out=deploy.tfplan
terraform apply deploy.tfplan
```

**Cost:** creating resources can cause cloud charges. Separate stacks let you deploy one provider at a time.

## Cleanup
Run `terraform destroy` from *each stack you actually deployed*. Never delete a different stack's state.

## Security
- Cloud credentials and `terraform.tfvars` are ignored by Git.
- Cloud access requires IAM/RBAC. Use short-lived credentials or managed identities where possible.
- CI here runs static validation only, **not** cloud deployments.

**Author:** Krishna Sharma · Azure / AWS / GCP portfolio demo.
