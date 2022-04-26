# LINUX

## Install Terraform

Build, change, and destroy infrastructure with Terraform.

<https://learn.hashicorp.com/terraform>

<https://learn.hashicorp.com/tutorials/terraform/install-cli>

```bash
curl -fsSL 'https://apt.releases.hashicorp.com/gpg' | sudo apt-key add -
echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/hashicorp.list
sudo apt update --fix-missing
sudo apt -y install terraform
```

## Install Azure-cli

Official Azure command-line interface.

<https://docs.microsoft.com/cli/azure/overview>

<https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli>

```bash
curl -fsSL 'https://packages.microsoft.com/keys/microsoft.asc' | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/azure-cli.list
sudo apt update --fix-missing
sudo apt -y install azure-cli
```

# MAC

## Install Terraform

Build, change, and destroy infrastructure with Terraform.

<https://learn.hashicorp.com/terraform>

<https://learn.hashicorp.com/tutorials/terraform/install-cli>

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## Install Azure-cli

Official Azure command-line interface.

<https://docs.microsoft.com/cli/azure/overview>

<https://formulae.brew.sh/formula/azure-cli>

```bash
brew install azure-cli
```

# Setup Azure-cli

```bash
az login --output yaml
```

```yaml
- cloudName: AzureCloud
  homeTenantId: <Your_Home_Tenant_Id>
  id: <Your_Id>
  isDefault: true
  managedByTenants: []
  name: <Your_Subscription_Name>
  state: Enabled
  tenantId: <HomeTenantId>
  user:
    name: your.user@example.com
    type: user
```

# Subscriptions

- [POC](./poc.md)

**Notes:**

```txt
https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli-apt?view=azure-cli-latest
https://docs.microsoft.com/pt-br/azure/developer/terraform/
https://docs.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-sku-not-available?tabs=azure-cli
https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed
```

# Azure

## Commands for useful information

### List of Azure Regions

```bash
az account list-locations --output table
```

### Find Images on Microsoft Azure

```bash
az vm image list --location centralus --subscription `az account show | jq -r '.id'` --publisher Canonical --sku "22_04-lts" --all --output table
```

### Resolve errors for SKU not available

<https://docs.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-sku-not-available?tabs=azure-cli>

#### To determine which SKUs are available in a location or zone

```bash
az vm list-skus --location centralus --zone --size Standard_D --all --output table
```

#### To determine which SKUs are available in a subscription using resource type

```bash
az vm list-skus --location centralus --zone --subscription `az account show | jq -r '.id'` --all --output table
```

- virtualMachines

<https://azure.microsoft.com/en-us/pricing/details/virtual-machines/series/>

```bash
az vm list-skus --location centralus --zone --subscription `az account show | jq -r '.id'` --resource-type virtualMachines --output table
```

```bash
az vm list-skus --location centralus --size Standard_DS1 --zone --subscription `az account show | jq -r '.id'` --resource-type virtualMachines --all --output table
```

- disks

```bash
az vm list-skus --location centralus --zone --subscription `az account show | jq -r '.id'` --resource-type disks --output table
```
