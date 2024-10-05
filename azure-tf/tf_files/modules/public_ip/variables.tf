variable "public_ip_name" {
  type        = string
  description = "Name of the public IP address"
}

variable "location" {
  type        = string
  description = "Location of the public IP"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name where the public IP is created"
}

