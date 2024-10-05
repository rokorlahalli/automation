#output "vnet_address_space" {
#  description = "The address space of the newly created vNet"
#  value       = var.vnet.address_space
#}
#
#output "vnet_id" {
#  description = "The id of the newly created vNet"
#  value       = var.vnet.id
#}
#
#output "vnet_location" {
#  description = "The location of the newly created vNet"
#  value       = var.location
#}
#
#output "vnet_name" {
#  description = "The Name of the newly created vNet"
#  value       = var.name
#}
#
output "vnet_subnets_name_id" {
  description = "Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet_subnets_name_id, subnet1)"
  value       = local.azurerm_subnet_name2id
}

# Output all subnet IDs as a map
output "vnet_id" {
  description = "Map of subnet names to their IDs"
  value       = { for s, subnet in azurerm_subnet.subnet : s => subnet.id }
}


output "vnet_subnets_name_cidr" {
  value = {
    for subnet in azurerm_subnet.subnet : subnet.name => subnet.address_prefixes[0]
  }
}
