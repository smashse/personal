resource "random_id" "template_rid" {
  keepers = {
    resource_group = azurerm_resource_group.template_rg.name
  }

  byte_length = 8
}
