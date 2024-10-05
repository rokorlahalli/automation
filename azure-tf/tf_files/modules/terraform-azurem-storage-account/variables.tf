variable "resource_group_name" {
  description = "Resource group for the storage account"
  type        = string
}

variable "location" {
  description = "Azure location for the storage account"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "container_name" {
  description = "Name of the blob container"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the storage account"
  type        = map(string)
}

variable "account_replication_type" {
    type        = string
}
