output "id" {
  value = azurerm_application_gateway.appgw.id
}

output "name" {
  value = azurerm_application_gateway.appgw.name
}

# Reference the existing subnet directly
output "subnet_id" {
  value = var.subnet_id  # Output the subnet_id passed to the module
}

# If you have the CIDR for the subnet, make sure it's accessible
output "subnet_cidr" {
  #value = azurerm_subnet.existing_subnet.address_prefixes[0]  # Reference the existing subnet CIDR if applicable
  value = var.subnet_cidr 
}

output "application_gateway_id" {
  value = azurerm_application_gateway.appgw.id
}

output "application_gateway_frontend_ip" {
  value = azurerm_application_gateway.appgw.frontend_ip_configuration[0].id
}
