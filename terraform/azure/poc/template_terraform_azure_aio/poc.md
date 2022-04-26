# POC.

This POC aims to provide a test environment for deploying [BotKube](https://www.botkube.io/) and [Velero](https://velero.io/) through Terraform in the [Microsoft Azure](https://azure.microsoft.com/pt-br/) cloud, using a [Kubernetes](https://kubernetes.io/) cluster provisioned on [Ubuntu](https://ubuntu.com/) [22.04](https://ubuntu.com/blog/ubuntu-22-04-lts-released) with [Microk8s](https://microk8s.io/).

## Set a subscription to be the current active subscription.

```bash
az account set --name <Your_Subscription_Name>
```

## Get a list of subscriptions for the logged in account.

```bash
az account list -o table
```

```text
Name                           CloudName    SubscriptionId                        State    IsDefault
------------------------       -----------  ------------------------------------  -------  -----------
<Your_Subscription_Name>       AzureCloud   <Your_Id>                             Enabled  True
```

## Get the details of a subscription.

```bash
az account show --output yaml
```

```yaml
environmentName: AzureCloud
homeTenantId: <Your_Home_Tenant_Id>
id: <Your_Id>
isDefault: true
managedByTenants: []
name: <Your_Subscription_Name>
state: Enabled
tenantId: <Your_Tenant_Id>
user:
  name: your.user@example.com
  type: user
```

## Create a service principal.

Automated tools that deploy or use Azure services - such as Terraform - should always have restricted permissions. Instead of having applications sign in as a fully privileged user, Azure offers service principals.

<https://docs.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash>

### If you're creating a service principal from Git Bash.

```bash
export MSYS_NO_PATHCONV=1
```

### To create a service principal.

```bash
az ad sp create-for-rbac --name sp_`az account show | jq -r '.name'` --role Contributor --scopes /subscriptions/`az account show | jq -r '.id'` --output yaml
```

```yaml
appId: <Your_SP_App_Id>
displayName: sp_<Your_Subscription_Name>
password: <Your_SP_Password>
tenant: <Your_SP_Tenant>
```

### POC variables.

```text
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

```bash
export ARM_SUBSCRIPTION_ID=`az account show | jq -r '.id'`
export ARM_TENANT_ID=`az account show | jq -r '.tenantId'`
export ARM_CLIENT_ID="<Your_SP_App_Id>"
export ARM_CLIENT_SECRET="<Your_SP_Password>"
```

```bash
az ad sp list --display-name sp_`az account show | jq -r '.name'` | jq -r '.[].appId'
```

Note: You might have to specify the tenant id to connect to the respective environment.

```bash
az account set --name <Your_Subscription_Name>
export ARM_TENANT_ID=`az account show | jq -r '.tenantId'`
az login --tenant $ARM_TENANT_ID
```

# Create test environments for provisioning validation using Workspaces in Terraform.

## Initialize and create Workspaces.

```bash
terraform init;
terraform workspace new poc;
```

## Change the zone name "your.domain" for your domain.

```bash
nano -c dns_zone.tf
```

```bash
resource "azurerm_dns_zone" "zone" {
  name                = "my.domain"
  resource_group_name = azurerm_resource_group.template_rg.name

  lifecycle {
    prevent_destroy = true
  }
}
```

## POC.

```bash
terraform workspace select poc;
ssh-keygen -m PEM -t rsa -b 4096 -f "access-`terraform workspace show`" -N 'petname' -C "test@example.com";
export ARM_SUBSCRIPTION_ID=`az account show | jq -r '.id'`;
export ARM_TENANT_ID=`az account show | jq -r '.tenantId'`;
export ARM_CLIENT_ID="<Your_SP_App_Id>";
export ARM_CLIENT_SECRET="<Your_SP_Password>";
terraform plan;
terraform apply
```

## Enable Backend support.

```bash
sed "
s/<azurerm_resource_group>/`terraform output azurerm_resource_group`/g;
s/<azurerm_storage_account>/`terraform output azurerm_storage_account`/g;
s/<azurerm_storage_container_tfstate>/`terraform output azurerm_storage_container_tfstate`/g;
" terraform.tf.example > terraform.tf
```

```bash
terraform init
```

## Enable Helm support.

### Copy Kubernetes config.

```bash
scp -i access-poc -r azureuser@<Your_Subscription_Name>.your.domain:"/home/azureuser/.kube/config" .
```

### Change IP for your endpoint instance.

```bash
sed -i "s/10.0.2.4/`terraform output -raw microk8s_control_instance`/g" config
```

### Once the Microk8s certificate is generated for the local IP, it is necessary to comment it out and skip the TLS verification.

```bash
nano -c config
```

```yaml
apiVersion: v1
clusters:
  - cluster:
      #certificate-authority-data: <REDACTED>
      insecure-skip-tls-verify: true
      server: https://<YOUR_PUBLIC_IP>:16443
    name: microk8s-cluster
contexts:
  - context:
      cluster: microk8s-cluster
      user: admin
    name: microk8s
current-context: microk8s
kind: Config
preferences: {}
users:
  - name: admin
    user:
      token: <REDACTED>
```

```bash
export KUBECONFIG=config
kubectl config view
```

```yaml
apiVersion: v1
clusters:
  - cluster:
      insecure-skip-tls-verify: true
      server: https://<YOUR_PUBLIC_IP>:16443
    name: microk8s-cluster
contexts:
  - context:
      cluster: microk8s-cluster
      user: admin
    name: microk8s
current-context: microk8s
kind: Config
preferences: {}
users:
  - name: admin
    user:
      token: REDACTED
```

```bash
kubectl get no
```

```text
NAME                                STATUS   ROLES    AGE   VERSION
poc-001-microk8s-control-instance   Ready    <none>    1h   v1.23.5-2+c812603a312d2b
```

### Enable Kubernetes and Helm provider for Terraform using Kubernetes config from Microk8s.

```bash
mv microk8s.tf.example microk8s.tf
terraform init
```

## Configure Helm module for BotKube

### Install BotKube to the Slack workspace using using the following instructions:

<https://www.botkube.io/installation/slack/#install-botkube-to-the-slack-workspace>

### Change the "channel" and "token" values to the one provided after enabling the BotKube app in Slack.

```bash
nano -c modules/helm/botkube/values/botkube_values.yaml
```

### Uncomment BotKube module

```bash
nano -c main.tf
```

```bash
module "helm_botkube" {
  source = "./modules/helm/botkube"
}

# module "helm_kubenav" {
#   source = "./modules/helm/kubenav"
# }

# module "helm_velero" {
#   source = "./modules/helm/velero"
# }
```

```bash
terraform init
terraform plan
terraform apply
```

## Configure Helm module for Velero.

### Create credentials to Velero.

```bash
sed "
s/<azurerm_resource_group>/`terraform output --raw azurerm_resource_group`/g;
s/<azurerm_storage_account>/`terraform output --raw azurerm_storage_account`/g;
s/<azurerm_storage_container_velero>/`terraform output azurerm_storage_container_velero`/g;
s/<terraform_workspace>/`terraform workspace show`/g;
s/<arm_cloud_name>/`az account show | jq -r '.environmentName'`/g;
s/<arm_subscription_id>/`az account show | jq -r '.id'`/g;
s/<arm_tenant_id>/`az account show | jq -r '.tenantId'`/g;
s/<arm_client_id>/"<Your_SP_App_Id>"/g;
s/<arm_client_secret>/"<Your_SP_Password>"/g;
s/<arm_resource_group>/`terraform output --raw azurerm_resource_group`/g;
" modules/helm/velero/values/velero_values.yaml.example > modules/helm/velero/values/velero_values.yaml
```

### Uncomment Velero module

```bash
nano -c main.tf
```

```bash
module "helm_botkube" {
  source = "./modules/helm/botkube"
}

# module "helm_kubenav" {
#   source = "./modules/helm/kubenav"
# }

module "helm_velero" {
  source = "./modules/helm/velero"
}
```

```bash
terraform init
terraform plan
terraform apply
```
