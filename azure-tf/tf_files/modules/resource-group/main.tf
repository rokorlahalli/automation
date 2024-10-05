# Main module for creating resource group

#provider "azurerm" {
#  features {}
#}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

#output "resource_group_name" {
#  value = azurerm_resource_group.rg.name
#}

#output "resource_group_location" {
#  value = azurerm_resource_group.rg.location
#}

