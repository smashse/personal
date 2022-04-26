variable "microk8s_control_instance_count" {
  type        = string
  description = "Instance count"
  default     = "1"
}

data "template_file" "microk8s_control_template" {
  template = file("./cloud_init/azure_ubuntu_microk8s.yaml")
  vars = {
    DOMAIN = azurerm_dns_zone.zone.name,
    ENV    = terraform.workspace
  }
}

resource "azurerm_linux_virtual_machine" "microk8s_control_instance" {
  count                 = var.microk8s_control_instance_count
  name                  = "${terraform.workspace}-00${count.index + 1}-microk8s-control-instance"
  location              = var.azure_location
  resource_group_name   = azurerm_resource_group.template_rg.name
  network_interface_ids = [azurerm_network_interface.microk8s_control_ni.id]
  size                  = "Standard_DS2"
  user_data             = base64encode(data.template_file.microk8s_control_template.rendered)

  os_disk {
    name                 = "${terraform.workspace}-00${count.index + 1}-microk8s-control-instance-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  computer_name                   = "${terraform.workspace}-00${count.index + 1}-microk8s-control-instance"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("./access-${terraform.workspace}.pub")
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.template_sa.primary_blob_endpoint
  }

  lifecycle {
    ignore_changes = [user_data]
  }

  tags = {
    environment = "${terraform.workspace}"
  }
}
