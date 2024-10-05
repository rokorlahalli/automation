resource "azurerm_virtual_network_peering" "src_to_dest" {
  for_each = var.spoke_vnets

  name                      = "${var.peering_name_prefix}-hub-to-${each.key}"
  resource_group_name       = var.src_resource_group_name
  virtual_network_name      = var.src_virtual_network_name
  remote_virtual_network_id = each.value.vnet_id

  allow_virtual_network_access = var.allow_virtual_src_network_access
  allow_forwarded_traffic      = var.allow_forwarded_src_traffic
  allow_gateway_transit        = var.allow_gateway_transit_src
  use_remote_gateways          = var.use_remote_gateways_src
}

resource "azurerm_virtual_network_peering" "dest_to_src" {
  for_each = var.spoke_vnets

  name                      = "${var.peering_name_prefix}-${each.key}-to-hub"
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = var.vnet_src_id

  allow_virtual_network_access = var.allow_virtual_dest_network_access
  allow_forwarded_traffic      = var.allow_forwarded_dest_traffic
  allow_gateway_transit        = var.allow_gateway_transit_dest
  use_remote_gateways          = var.use_remote_gateways_dest
}


