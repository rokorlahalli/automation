name  = "gosure-hub-vnet"
address_space  = ["10.10.0.0/16"]
location = "Central India"
resource_group_name  = "gosure-hub-rg"

subnets = {
  "gosure-hub-vm" = {
    name             = "gosure-hub-vm"
    address_prefixes = ["10.10.16.0/24"]
  },
  "gosure-hub-endpoint" = {
    name             = "gosure-hub-endpoint"
    address_prefixes = ["10.10.18.0/24"]
  }
}

tenant_id = "0112ed78-abf7-40ec-ac17-d7ec57be0105"
subscription_id = "45e11d13-6a36-4199-a853-61c0c5a00b6a"


global_tags = {
  environment = "hub"
  ManagedBy   = "Terraform"
  project     = "Gosure"
} 

# cluster_name = "gosure-hub-aks-cluster"
# kubernetes_version  = "1.29.7"
# agents_pool_name     = "systempool"
# agents_size        = "Standard_DS2_v2"
# agents_count       = 2
# cluster_log_analytics_workspace_name  = "gosure-hub-aks-log-analytics-workspace"
# role_based_access_control_enabled   = true
# rbac_aad                            = false
# private_cluster_enabled             = true
# prefix                              = "gosure-hub"
# admin_username                      = "azureuser"
# user_identity_name                  = "hub-aks-gosure"
# node_pool_name                      = "userpool"
# vm_size                             = "Standard_DS2_v2"
# node_count                          = 2
# os_disk_size_gb                     = 30
# #ssh_key                              = file("/home/rohit/.ssh/id_rsa.pub")
# identity_type = "UserAssigned"


# storage_account_name  = "stagegosure"
# container_name        = "stagecontainer"
# account_replication_type =  "LRS"


nsg_name = "vm-nsg"

inbound_rules = [
  
  # Allow publicly open Port 1194 (for VPN or other purposes)
  {
    name                                       = "allow-1194-public"
    priority                                   = 1002
    access                                     = "Allow"
    protocol                                   = "Udp"  # Use "Udp" if you need UDP
    source_address_prefix                      = "0.0.0.0/0"
      source_port_range                          = "*"
    destination_address_prefix                 = "*"
    destination_port_range                     = "1194"
    description                                = "Allow Port 1194 public"
  },
  
  # Allow SSH from specific IP 4.213.60.133
  {
    name                                       = "allow-ssh-specific-ip"
    priority                                   = 1003
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_address_prefix                 = "*"
    destination_port_range                     = "22"
    description                                = "Allow SSH from specific IP"
      source_address_prefixes = [
    "123.252.234.141/32",
    "4.213.60.133/32"
   ]
  },

  # Allow HTTP (80) from specific IP 
  {
    name                                       = "allow-http-specific-ip"
    priority                                   = 1004
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_address_prefix                      = "123.252.234.141/32"
      source_port_range                          = "*"
    destination_address_prefix                 = "*"
    destination_port_range                     = "80"
    description                                = "Allow HTTP from specific IP"
  },

  # Allow HTTPS (443) from specific IP 
  {
    name                                       = "allow-https-specific-ip"
    priority                                   = 1005
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_address_prefix                      = "123.252.234.141/32"
      source_port_range                        = "*"
    destination_address_prefix                 = "*"
    destination_port_range                     = "443"
    description                                = "Allow HTTPS from specific IP"
  }
]

  outbound_rules = [
    {
      name                                       = "allow-outbound-all"
      priority                                   = 1001
      access                                     = "Allow"
      protocol                                   = "*"
      source_address_prefix                      = "*"
      source_port_range                          = "*"
      destination_address_prefix                 = "0.0.0.0/0"
      destination_port_range                     = "*"
      description                                = "Allow all outbound"
    }
  ]


##
vm_configs = {
  "vpn" = {
    if_name             = "vpn-nic"
    vm_name             = "vpn-vm"
    vm_size             = "Standard_DS1_v2"
    admin_username      = "ubuntu"
    allocation_method   = "Static"
    create_public_ip    = true
    ssh_public_key_path = "./keys/tf_keys.pub"
  },
  "controlplane" = {
    if_name             = "controlplane-nic"
    vm_name             = "controlplane-vm"
    vm_size             = "Standard_DS1_v2"
    admin_username      = "ubuntu"
    allocation_method   = "Static"
    create_public_ip    = false
    ssh_public_key_path = "./keys/tf_keys.pub"
  }
}

pvt_endpoint_name = "mongoatlas-ep"
external_pvt_resource_id = "/subscriptions/6fc03fcf-3724-46c1-84de-e38fa18e8186/resourceGroups/rg_66fa8124a0b8f160beb9c247_ceikt0vr/providers/Microsoft.Network/privateLinkServices/pls_66fbb314e2080e4f1635844f"
