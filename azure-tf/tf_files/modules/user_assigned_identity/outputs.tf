output "identity_id" {
  value       = azurerm_user_assigned_identity.this.id
  description = "The ID of the User Assigned Identity"
}

output "identity_principal_id" {
  value       = azurerm_user_assigned_identity.this.principal_id
  description = "The Principal ID of the User Assigned Identity"
}

