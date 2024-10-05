# output "src_to_dest_peering_id" {
#   description = "The ID of the VNet peering from the source to the destination."
#   value       = azurerm_virtual_network_peering.src_to_dest.id
# }

# output "dest_to_src_peering_id" {
#   description = "The ID of the VNet peering from the destination to the source."
#   value       = azurerm_virtual_network_peering.dest_to_src.id
# }


output "src_to_dest_peering_ids" {
  description = "The IDs of the VNet peering from the source (Hub) to the destination (Spoke) VNets."
  value       = { for k, v in azurerm_virtual_network_peering.src_to_dest : k => v.id }
}

output "dest_to_src_peering_ids" {
  description = "The IDs of the VNet peering from the destination (Spoke) VNets to the source (Hub)."
  value       = { for k, v in azurerm_virtual_network_peering.dest_to_src : k => v.id }
}

