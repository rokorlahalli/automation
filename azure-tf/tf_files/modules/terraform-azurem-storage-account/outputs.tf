output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storage.name
}

output "container_name" {
  description = "The name of the blob container"
  value       = azurerm_storage_container.blob_container.name
}

