name  = "gosure-uat"
address_space  = ["10.20.0.0/16"]
location = "Central India"
resource_group_name  = "gosure-uat"

subnet_gosure_aks2 = {
  name           = "gosure-aks-2-subnet"
  address_prefix = ["10.20.0.0/20"]
}

subnet_gosure_vm = {
  name           = "gosure-vm-subnet"
  address_prefix = ["10.20.16.0/20"]
}

subnet_gosure_aks1 = {
  name           = "gosure-aks-1-subnet"
  address_prefix = ["10.20.32.0/20"]
}

subnet_gosure_endpoint = {
  name           = "gosure-endpoint-subnet"
  address_prefix = ["10.20.64.0/24"]
}

subnets = {
  "gosure-aks-subnet" = {
    name             = "gosure-aks-subnet"
    address_prefixes = ["10.20.0.0/20"]
  },
  "gosure-vm-subnet" = {
    name             = "gousre-vm-subnet"
    address_prefixes = ["10.20.16.0/24"]
  },
  "gosure-endpoint-subnet" = {
    name             = "gosure-endpoint-subnet"
    address_prefixes = ["10.20.18.0/24"]
  },
  "gosure-appgw-subnet" = {
    name             = "gosure-appgw-subnet"
    address_prefixes = ["10.20.19.0/28"]
  }
}

#appId  = "3d5c8ff4-ac51-4706-ae47-ef7648189e7e"
#apppassword = "TEI8Q~UvdYhyzEYP0_DNTrFDet5gnj6tD7Vcqb6_"

subscription_id = "7172ed41-24a4-440c-b608-770459b41f18"
uami_name = "gosure-msi"
uami_rg_name = "gosure-rg"

global_tags = {
  environment = "uat"
  ManagedBy   = "Terraform"
  project     = "Gosure"
} 

cluster_name = "gosure-uat-aks-cluster"
kubernetes_version  = "1.29.7"
agents_pool_name     = "systempool"
agents_size        = "Standard_D2_v3"
agents_count       = 2
cluster_log_analytics_workspace_name  = "gosure-uat-aks-log-analytics-workspace"
role_based_access_control_enabled   = true
rbac_aad                            = false
private_cluster_enabled             = true
prefix                              = "gosure-uat"
admin_username                      = "azureuser"
user_identity_name                  = "uat-aks-gosure"
node_pool_name                      = "userpool"
vm_size        = "Standard_D2_v3"
aks_sku_tier   = "Standard"
#node_count                          = 2
os_disk_size_gb                     = 30
#ssh_key                              = file("/home/rohit/.ssh/id_rsa.pub")
identity_type = "UserAssigned"
appgw_capacity = 2
appgw_name = "gosure-uat-appgw"
public_ip_name = "gosure-uat-appgw-ip"
# SKU configuration
sku_name            = "WAF_v2"  # You can adjust this to another SKU if needed
sku_tier            = "WAF_v2"  # The tier corresponding to the SKU
waf_enabled         = true
firewall_mode       = "Detection"

##AKS Scaling

#autoscale_agent_node = true
#agent_min_node_count = 1
#agent_max_node_count = 3

autoscale_user_node = true
user_min_node_count = 1
user_max_node_count = 3

##
#vm_configs = {
#  "vpn" = {
#    if_name             = "vpn-nic"
#    vm_name             = "vpn-vm"
#    vm_size             = "Standard_DS1_v2"
#    admin_username      = "ubuntu"
#    allocation_method   = "Static"
#    create_public_ip    = true
#    ssh_public_key_path = "./keys/tf_keys.pub"
#  },
#  "controlplane" = {
#    if_name             = "controlplane-nic"
#    vm_name             = "controlplane-vm"
#    vm_size             = "Standard_DS1_v2"
#    admin_username      = "ubuntu"
#    allocation_method   = "Static"
#    create_public_ip    = false
#    ssh_public_key_path = "./keys/tf_keys.pub"
#  }
#}
