# modules/storage-account/main.tf

resource "azurerm_storage_account" "storage" {
  name                      = var.storage_account_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = var.account_replication_type   #"LRS"

  #lifecycle {
   # prevent_destroy = true
  #}

  # Add any other necessary settings here
}


resource "azurerm_storage_container" "blob_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
  #lifecycle {
   # prevent_destroy = true
  #}
}
