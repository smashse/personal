resource "azurerm_dns_cname_record" "grafana" {
  name                = "grafana.${terraform.workspace}"
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_resource_group.template_rg.name
  ttl                 = 300
  record              = azurerm_dns_a_record.ws.fqdn
  depends_on          = [azurerm_dns_a_record.ws]
}

resource "azurerm_dns_cname_record" "prometheus" {
  name                = "prometheus.${terraform.workspace}"
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_resource_group.template_rg.name
  ttl                 = 300
  record              = azurerm_dns_a_record.ws.fqdn
  depends_on          = [azurerm_dns_a_record.ws]
}

resource "azurerm_dns_cname_record" "kubenav" {
  name                = "kubenav.${terraform.workspace}"
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_resource_group.template_rg.name
  ttl                 = 300
  record              = azurerm_dns_a_record.ws.fqdn
  depends_on          = [azurerm_dns_a_record.ws]
}