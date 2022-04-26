resource "azurerm_resource_group" "template_rg" {
  name     = "${terraform.workspace}-rg"
  location = var.azure_location

  tags = {
    environment = "${terraform.workspace}"
  }
}
