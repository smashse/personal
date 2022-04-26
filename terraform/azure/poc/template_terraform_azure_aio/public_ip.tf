resource "azurerm_public_ip" "microk8s_control_pip" {
  name                = "${terraform.workspace}-microk8s-control-pip"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.template_rg.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "${terraform.workspace}"
  }
}