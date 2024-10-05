variable "name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "IP address space for the VNet"
  type        = list(string)
}

variable "location" {
  description = "Azure region where the VNet will be deployed"
  type        = string
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "resource_group_name" {
  description = "Resource group where the VNet will be created"
  type        = string
}

#variable "subnet_gosure_aks2" {
#  description = "The gosure AKS subnet"
#  type = object({
#    name           = string
#    address_prefix = list(string)
#  })
#}
#
#variable "subnet_gosure_vm" {
#  description = "The gosure VM subnet"
#  type = object({
#    name           = string
#    address_prefix = list(string)
#  })
#}
#
#variable "subnet_gosure_aks1" {
#  description = "The gosure AKS subnet"
#  type = object({
#    name           = string
#    address_prefix = list(string)
#  })
#}
#
#variable "subnet_gosure_endpoint" {
#  description = "The gosure Endpoint subnet"
#  type = object({
#    name           = string
#    address_prefix = list(string)
#  })
#}

#variable "appId" {
#  description = "The client app ID for the AKS cluster (AAD integration)."
#  type        = string
#}
#
#variable "apppassword" {
#  description = "The server app ID for the AKS cluster (AAD integration)."
#  type        = string
#}

#variable "server_app_secret" {
#  description = "The server app secret for the AKS cluster (AAD integration)."
#  type        = string
#  sensitive   = true
#}

#variable "admin_username" {
#  description = "The admin username for the Linux profile"
#  type        = string
#  default     = null
#}

variable "public_ssh_key" {
  description = "Public SSH key to access the AKS nodes"
  type        = string
  default     = null
}

variable "uami_name" {
  type = string
}

variable "uami_rg_name" {
  type = string
}

variable "global_tags" {
  type = map(string)
  description = "Tags to be applied to all resources"
}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
  description = "Mapping of subnet definitions"
}

variable "cluster_name" {
  type        = string
  description = "The name of the AKS cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "The version of Kubernetes to deploy on AKS"
}

variable "agents_pool_name" {
  type        = string
  description = "The version of Kubernetes to deploy on AKS"
}

variable "agents_count" {
  type        = number
  description = "The number of agents (nodes) in the AKS cluster"
}

variable "cluster_log_analytics_workspace_name" {
  type        = string
  description = "The name of the Log Analytics workspace for the AKS cluster"
}

variable "role_based_access_control_enabled" {
  type        = bool
  description = "Enable or disable Role-Based Access Control (RBAC) for the AKS cluster"
}

variable "rbac_aad" {
  type        = bool
  description = "Enable or disable Azure AD integration for Role-Based Access Control (RBAC)"
}

variable "private_cluster_enabled" {
  type        = bool
  description = "Enable or disable private cluster for the AKS cluster"
}

variable "prefix" {
  type        = string
  description = "The name of the prefix"
}

variable "user_identity_name" {
  type        = string
  description = "The name of the user_identity"
}

variable "admin_username" {
  type        = string
  description = "The name of the admin user"
}

variable "node_pool_name" {
  type        = string
  description = "The name of the user node pool"
}

variable "vm_size" {
  type        = string
  description = "The size of the VM"
}

variable "agents_size" {
  type        = string
  description = "The size of the VM"
}

#variable "node_count" {
#  type        = number
#  description = "The number of nodes in the default node pool"
#}

variable "os_disk_size_gb" {
  type        = number
  description = "The size of the OS disk for the nodes in GB"
  default     = 30  # You can set a default value if desired
}

variable "identity_type" {
  type        = string
  description = "identity_type"
}

variable "appgw_name" {
  type = string
}

variable "appgw_capacity" {
  type = number
}

#variable "subnet_id" {
#  type = string
#}

#variable "public_ip_id" {
#  type = string
#}

variable "public_ip_name" {
  type = string
}

#variable "client_id" {
#  type        = string
#  description = "Azure Client ID"
#}
#
#variable "client_secret" {
#  type        = string
#  description = "Azure SP Secret"
#}
#
#variable "tenant_id" {
#  type        = string
#  description = "Azure Tenant ID"
#}
#
#variable "account_replication_type" {
#  type        = string
#}
#
#variable "storage_account_name" {
#  description = "The name of the storage account."
#  type        = string
#}
#
#variable "container_name" {
#  description = "The name of the blob container."
#  type        = string
#}

# WAF configuration variables
variable "waf_enabled" {
  description = "Enable or disable the WAF feature."
  type        = bool
  #default     = true
}

variable "firewall_mode" {
  description = "The firewall mode for WAF, either 'Detection' or 'Prevention'."
  type        = string
  default     = "Prevention"
}

variable "sku_name" {
  description = "The SKU name of the Application Gateway."
  type        = string
  #default     = "WAF_v2"
}

variable "sku_tier" {
  description = "The SKU tier of the Application Gateway."
  type        = string
  #default     = "WAF_v2"
}

#variable "agent_min_node_count" {
#  description = "Minimum number of nodes for agent node autoscaling."
#  type        = number
#}
#
#variable "agent_max_node_count" {
#  description = "Maximum number of nodes for agnet node autoscaling."
#  type        = number
#}
#
#variable "autoscale_agent_node" {
#  description = "autoscale must be enabled on the system agent pool?"
#  type        = bool
#}

variable "user_min_node_count" {
  description = "Minimum number of nodes for agent node autoscaling."
  type        = number
}

variable "user_max_node_count" {
  description = "Maximum number of nodes for agnet node autoscaling."
  type        = number
}

variable "autoscale_user_node" {
  description = "autoscale must be enabled on the system agent pool?"
  type        = bool
}

variable "aks_sku_tier" {
  description = "The SKU tier for the AKS cluster. Options are Free or Standard."
  type        = string
  default     = "Standard"  # Set default to Standard for production use
}


##VM
#variable "vm_configs" {
#  description = "Map of VM configurations"
#  type        = map(object({
#    if_name             = string
#    vm_name             = string
#    vm_size             = string
#    admin_username      = string
#    allocation_method   = string
#    ssh_public_key_path = string
#    create_public_ip    = bool
#  }))
#}
