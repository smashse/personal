resource "azurerm_dns_a_record" "ws" {
  name                = terraform.workspace
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_resource_group.template_rg.name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.microk8s_control_pip.id
  depends_on          = [azurerm_dns_zone.zone]
}
