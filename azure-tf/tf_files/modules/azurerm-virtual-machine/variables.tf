variable "vm_configs" {
  description = "Map of VM configurations"
  type        = map(object({
    if_name             = string
    vm_name             = string
    vm_size             = string
    admin_username      = string
    allocation_method   = string
    ssh_public_key_path = string
    create_public_ip    = bool
  }))
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the existing subnet where the VMs will be deployed"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources"
  default     = {}
}
