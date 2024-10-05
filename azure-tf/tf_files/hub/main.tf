
locals {
  global_tags = var.global_tags
}

module "resource_group" {
  source              = "../modules/resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
  #tags   = local.global_tags
}

module "vnet" {
  source              = "../modules/terraform-azurerm-virtual-network"
  name                = var.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  tags   = local.global_tags
}


module "subnets" {
  source               = "../modules/terraform-azurerm-subnets"
  subnets = { for subnet_key, subnet_value in var.subnets :
    subnet_key => {
      name             = subnet_value.name
      address_prefixes = subnet_value.address_prefixes
      tags             = local.global_tags
    }
  }
  resource_group_name  = var.resource_group_name
  virtual_network_address_space = module.vnet.address_space
  virtual_network_name = module.vnet.name
  virtual_network_id   = module.vnet.id
  virtual_network_location = var.location
  depends_on = [module.vnet]

}


module "udr_table" {
  source              = "../modules/terraform-azurerm-route-table"
  #version             = "2.0.0"

  # Route table properties
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  name    = "Gosure-CustomRouteTable"

  # Routes
  routes = [
    {
      name                   = "Vnet_Local"
      address_prefix         = module.vnet.address_space[0]
      next_hop_type          = "VnetLocal" # can also be Internet, VnetLocal, VirtualNetworkGateway, etc.
      #next_hop_in_ip_address = "10.0.0.4" # Replace with your Virtual Appliance IP
    },
    {
      name                   = "Internet"
      address_prefix         = "0.0.0.0/0" # Default route
      next_hop_type          = "Internet"  # Sends traffic to the Internet
    }
  ]
  tags   = local.global_tags
}

#Network Security Group Module
module "network_security_group" {
  source              = "../modules/terraform-azurerm-network-security-group"
  name                = var.nsg_name
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  tags                = local.global_tags
  inbound_rules       = var.inbound_rules
  outbound_rules      = var.outbound_rules
  vpn_subnet_id       = module.subnets.vnet_id["gosure-hub-vm"]
}


#VM module
module "vms" {
  source              = "../modules/azurerm-virtual-machine"
  vm_configs          = var.vm_configs
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  subnet_id           = module.subnets.vnet_id["gosure-hub-vm"]
  tags                = local.global_tags
}

#resource "azurerm_subnet_route_table_association" "association" {
#  for_each        = module.subnets
#  subnet_id       = each.value.id
#  route_table_id  = module.udr_table.id
#}

#User Identity

# module "user_identity" {
#   source              = "../modules/user_assigned_identity"
#   identity_name      = var.user_identity_name
#   resource_group_name = module.resource_group.resource_group_name
#   location            = module.resource_group.resource_group_location
# }

# MOngo Atlas private endpoint

module "private_endpoint" {
  source = "../modules/private_endpoint"

  name                         = var.pvt_endpoint_name
  location                     = var.location
  resource_group_name           = module.resource_group.resource_group_name
  subnet_id                    = module.subnets.vnet_id["gosure-hub-endpoint"]
  private_connection_resource_id = var.external_pvt_resource_id
  subresource_names            = ["mongo"]  # Example: "blob"
  is_manual_connection         = false
  tags                         = local.global_tags
}


