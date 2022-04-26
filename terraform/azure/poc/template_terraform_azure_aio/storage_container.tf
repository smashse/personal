resource "azurerm_storage_container" "tfstate_container" {
  name                  = "${terraform.workspace}-tfstate-container"
  storage_account_name  = azurerm_storage_account.template_sa.name
  container_access_type = "private"
  lifecycle {
    prevent_destroy = false
  }
}


resource "azurerm_storage_container" "velero_container" {
  name                  = "${terraform.workspace}-velero-container"
  storage_account_name  = azurerm_storage_account.template_sa.name
  container_access_type = "private"
  lifecycle {
    prevent_destroy = false
  }
}
