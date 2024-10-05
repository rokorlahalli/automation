#locals {
#  global_tags = var.global_tags
#}

module "azure_vnet_peering" {
  source = "../modules/terraform-vnet-to-vnet-peerings"

  vnet_src_id              = var.vnet_src_id  
  src_resource_group_name  = var.src_resource_group_name   
  src_virtual_network_name = var.src_virtual_network_name  
  spoke_vnets              = var.spoke_vnets
  allow_forwarded_src_traffic       = var.allow_forwarded_src_traffic
  allow_forwarded_dest_traffic      = var.allow_forwarded_dest_traffic
  allow_virtual_src_network_access  = var.allow_virtual_src_network_access
  allow_virtual_dest_network_access = var.allow_virtual_dest_network_access
  allow_gateway_transit_src         = var.allow_gateway_transit_src
  allow_gateway_transit_dest        = var.allow_gateway_transit_dest
  use_remote_gateways_src           = var.use_remote_gateways_src
  use_remote_gateways_dest          = var.use_remote_gateways_dest
  peering_name_prefix               = var.peering_name_prefix
}
