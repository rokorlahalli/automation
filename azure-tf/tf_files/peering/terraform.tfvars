##Peering

peering_name_prefix = "vnet-peering"

# Azure Subscription and Tenant IDs
azure_subscription_id   = "45e11d13-6a36-4199-a853-61c0c5a00b6a"
preprod_subscription_id = "45e11d13-6a36-4199-a853-61c0c5a00b6a"
azure_tenant_id         = "0112ed78-abf7-40ec-ac17-d7ec57be0105"

# Source VNet (Hub) Configuration
vnet_src_id              =  "/subscriptions/45e11d13-6a36-4199-a853-61c0c5a00b6a/resourceGroups/gosure-hub-rg/providers/Microsoft.Network/virtualNetworks/gosure-hub-vnet" 
src_resource_group_name  = "gosure-hub-rg"
src_virtual_network_name = "gosure-hub-vnet"

# Spoke VNets Configuration
spoke_vnets = {
  uat = {
    vnet_id              = "/subscriptions/45e11d13-6a36-4199-a853-61c0c5a00b6a/resourceGroups/gosure-test/providers/Microsoft.Network/virtualNetworks/gosure-uat"
    resource_group_name  = "gosure-test"
    virtual_network_name = "gosure-uat"
  },
  # prod = {
  #   vnet_id              = "/subscriptions/7172ed41-24a4-440c-b608-770459b41f18/resourceGroups/gosure-test/providers/Microsoft.Network/virtualNetworks/gosure-uat"
  #   resource_group_name  = "gosure-test"
  #   virtual_network_name = "gosure-uat"
  # }
}


  allow_forwarded_src_traffic       = true
  allow_forwarded_dest_traffic      = true
  allow_virtual_src_network_access  = true
  allow_virtual_dest_network_access = true
  allow_gateway_transit_src         = false
  allow_gateway_transit_dest        = false
  use_remote_gateways_src           = false
  use_remote_gateways_dest          = false
