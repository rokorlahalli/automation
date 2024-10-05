variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "resource_group" {
  description = "Resource group where the AKS cluster is located"
  type        = string
}

variable "node_pool_name" {
  description = "Name of the user node pool"
  type        = string
}

#variable "node_count" {
#  description = "Number of nodes in the node pool"
#  type        = number
#  default     = 1
#}

variable "vm_size" {
  description = "The size of the Virtual Machine instances in the node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "max_pods" {
  description = "The maximum number of pods that can run on a node"
  type        = number
  default     = 110
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB for the node pool"
  type        = number
  default     = 128
}

# In the module's variables.tf file
variable "enable_auto_scaling" {
  type    = bool
  #default = false
}

variable "min_count" {
  type    = number
  #default = 1
}

variable "max_count" {
  type    = number
  #default = 5
}
