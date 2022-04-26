resource "azurerm_dns_zone" "zone" {
  name                = "your.domain"
  resource_group_name = azurerm_resource_group.template_rg.name

  lifecycle {
    prevent_destroy = true
  }
}
