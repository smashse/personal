output "azurerm_resource_group" {
  value = azurerm_resource_group.template_rg.name
}

output "azurerm_storage_account" {
  value = azurerm_storage_account.template_sa.name
}

output "azurerm_storage_container_tfstate" {
  value = azurerm_storage_container.tfstate_container.name
}

output "azurerm_storage_container_velero" {
  value = azurerm_storage_container.velero_container.name
}

output "microk8s_control_instance" {
  value = azurerm_public_ip.microk8s_control_pip.ip_address
}

output "dns_zone" {
  value = [
    azurerm_dns_zone.zone.name,
    azurerm_dns_zone.zone.name_servers
  ]
}

output "endpoints" {
  value = [
    azurerm_dns_a_record.ws.fqdn,
    azurerm_dns_cname_record.grafana.fqdn,
    azurerm_dns_cname_record.prometheus.fqdn,
    azurerm_dns_cname_record.kubenav.fqdn
  ]
}
