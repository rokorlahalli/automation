variable "identity_name" {
  type        = string
  description = "The name of the User Assigned Identity"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region to create the identity in"
}

