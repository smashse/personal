# Create test environments for provisioning validation using Workspaces in Terraform.

## Enable the backend and create Workspaces

```bash
mv terraform.tf.example terraform.tf;
terraform init;
terraform workspace new dev;
terraform workspace new hml;
terraform workspace new prd;
```

## DEV

```bash
terraform workspace select dev;
ssh-keygen -f "access-`terraform workspace show`" -P 'petname' -C "test@example.com";
export TF_VAR_aws_profile="your.profile";
export TF_VAR_domain_name="`terraform workspace show`.dev.local";
#export TF_VAR_ssh_key_pair_name="access-`terraform workspace show`";
terraform apply
```

## HML

```bash
terraform workspace select hml;
ssh-keygen -f "access-`terraform workspace show`" -P 'petname' -C "test@example.com";
export TF_VAR_aws_profile="your.profile";
export TF_VAR_domain_name="`terraform workspace show`.hml.local";
#export TF_VAR_ssh_key_pair_name="access-`terraform workspace show`";
terraform apply
```

## PRD

```bash
terraform workspace select prd;
ssh-keygen -f "access-`terraform workspace show`" -P 'petname' -C "test@example.com";
export TF_VAR_aws_profile="your.profile";
export TF_VAR_domain_name="`terraform workspace show`.prd.local";
#export TF_VAR_ssh_key_pair_name="access-`terraform workspace show`";
terraform apply
```
