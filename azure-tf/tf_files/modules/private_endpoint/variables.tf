variable "name" {
  description = "The name of the private endpoint"
  type        = string
}

variable "location" {
  description = "The location where the private endpoint should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet in which the private endpoint will be created"
  type        = string
}

variable "private_connection_resource_id" {
  description = "The resource ID of the external private link service"
  type        = string
}

variable "subresource_names" {
  description = "A list of subresources to connect to"
  type        = list(string)
}

variable "is_manual_connection" {
  description = "Specifies if the connection should be manually approved"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to be applied to the private endpoint"
  type        = map(string)
  default     = {}
}
