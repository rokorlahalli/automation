
# Generate SSH key pair
resource "tls_private_key" "gosure" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "private_key_pem" {
  description = "The private SSH key in PEM format"
  value       = tls_private_key.gosure.private_key_pem
  sensitive   = true
}

output "public_key_openssh" {
  description = "The public SSH key in OpenSSH format"
  value       = tls_private_key.gosure.public_key_openssh
}


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

#resource "azurerm_subnet_route_table_association" "association" {
#  for_each        = module.subnets
#  subnet_id       = each.value.id
#  route_table_id  = module.udr_table.id
#}

#User Identity

module "user_identity" {
  source              = "../modules/user_assigned_identity"
  identity_name      = var.user_identity_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}

##AKS 

module "aks" {
  source              = "../modules/terraform-azurerm-aks"
  resource_group_name = module.resource_group.resource_group_name
  cluster_name        = var.cluster_name
  location            = module.resource_group.resource_group_location
  kubernetes_version  = var.kubernetes_version
  agents_pool_name      = var.agents_pool_name
  agents_count        = var.agents_count
  agents_size         = var.agents_size
  #enable_auto_scaling = var.autoscale_agent_node
  #sys_min_count           = var.agent_min_node_count
  #sys_max_count           = var.agent_max_node_count
  #ssh_key              = file("/home/rohit/.ssh/id_rsa.pub")
  #kube_config         = module.aks.kube_config
  cluster_log_analytics_workspace_name = var.cluster_log_analytics_workspace_name
  role_based_access_control_enabled = var.role_based_access_control_enabled
  rbac_aad = var.rbac_aad
  sku_tier = var.aks_sku_tier
  private_cluster_enabled = var.private_cluster_enabled
  vnet_subnet_id  = module.subnets.vnet_subnets_name_id["gosure-aks-subnet"]
  network_plugin     = "azure"
  ingress_application_gateway_enabled           = true
  brown_field_application_gateway_for_ingress = {
    id          = module.app_gateway.id  # Ensure this is part of the object
    name        = module.app_gateway.name  # You may need to define this output
    subnet_id   = module.subnets.vnet_subnets_name_id["gosure-appgw-subnet"]  # Define this output if needed
    subnet_cidr = module.subnets.vnet_subnets_name_cidr["gosure-appgw-subnet"]  # Define this output if needed
  }
  prefix              = var.prefix
  identity_type       = var.identity_type
  identity_ids         = [module.user_identity.identity_id]
  #identity {
  #  type = "UserAssigned"
  #  user_identity_ids = [module.user_identity.identity_id]
  #}
  
  #aad_profile {
  #  client_id     = var.appId
  #  client_secret = var.apppassword
  #}
  
  admin_username = var.admin_username
  public_ssh_key = file("/home/rohit/.ssh/id_rsa.pub")
  tags                = local.global_tags
  depends_on = [module.resource_group]
}

#output "kube_config" {
#  value     = module.aks.kube_config
#  sensitive = true
#}


## User Node Pool

module "user_node_pool" {
  source                = "../modules/aks-user-node-pool"
  node_pool_name        = var.node_pool_name
  resource_group        = module.resource_group.resource_group_name
  aks_cluster_name      = var.cluster_name
  vm_size               = var.vm_size  # Example size
  enable_auto_scaling   = var.autoscale_user_node
  min_count             = var.user_min_node_count
  max_count             = var.user_max_node_count
  #node_count            = var.node_count
  os_disk_size_gb       = var.os_disk_size_gb
  #tags                 = local.global_tags
  depends_on = [module.aks]
}

#Public IP
module "public_ip" {
  source              = "../modules/public_ip"
  public_ip_name      = var.public_ip_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}

#Application Gateway
module "app_gateway" {
  source              = "../modules/app_gateway"
  appgw_name          = var.appgw_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  waf_enabled         = var.waf_enabled
  firewall_mode       = var.firewall_mode
  capacity            = var.appgw_capacity
  subnet_id           = module.subnets.vnet_subnets_name_id["gosure-appgw-subnet"]
  subnet_cidr         = module.subnets.vnet_subnets_name_cidr["gosure-appgw-subnet"]
  public_ip_id        = module.public_ip.public_ip_id
  
  tags                = local.global_tags
}

#AGIC
#module "agic" {
#  source                = "../modules/agic"
#  #kubernetes_cluster_id = module.aks.aks_id
#  #gateway_id            = module.app_gateway.id
#  #subnet_cidr           = module.subnets.vnet_subnets_name_id["gosure-appgw-subnet"]
#}


##VM module
#module "vms" {
#  source              = "../modules/azurerm-virtual-machine"
#  vm_configs          = var.vm_configs
#  resource_group_name = module.resource_group.resource_group_name
#  location            = var.location
#  subnet_id           = module.subnets.vnet_subnets_name_id["gosure-appgw-subnet"]
#  tags                = local.global_tags
#}
