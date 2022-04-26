resource "azurerm_network_interface" "microk8s_control_ni" {
  name                = "${terraform.workspace}-microk8s-control-ni"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.template_rg.name

  ip_configuration {
    name                          = "${terraform.workspace}-microk8s-control-ipc"
    subnet_id                     = azurerm_subnet.template_sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.microk8s_control_pip.id
  }

  tags = {
    environment = "${terraform.workspace}"
  }
}

resource "azurerm_network_interface_security_group_association" "microk8s_control" {
  network_interface_id      = azurerm_network_interface.microk8s_control_ni.id
  network_security_group_id = azurerm_network_security_group.microk8s_control_nsg.id
}
