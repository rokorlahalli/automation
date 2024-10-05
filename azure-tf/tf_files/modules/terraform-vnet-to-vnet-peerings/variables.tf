variable "vnet_src_id" {
  description = "The ID of the source virtual network (Hub VNet)."
  type        = string
}

variable "src_resource_group_name" {
  description = "The name of the resource group that contains the source virtual network."
  type        = string
}

variable "src_virtual_network_name" {
  description = "The name of the source virtual network (Hub VNet)."
  type        = string
}

variable "spoke_vnets" {
  description = "A map of spoke VNets with their resource group names, VNet names, and VNet IDs."
  type = map(object({
    vnet_id             = string
    resource_group_name = string
    virtual_network_name = string
  }))
}

variable "allow_forwarded_src_traffic" {
  description = "Allow forwarded traffic for the source VNet."
  type        = bool
  default     = false
}

variable "allow_forwarded_dest_traffic" {
  description = "Allow forwarded traffic for the destination VNet."
  type        = bool
  default     = false
}

variable "allow_virtual_src_network_access" {
  description = "Allow virtual network access for the source VNet."
  type        = bool
  default     = true
}

variable "allow_virtual_dest_network_access" {
  description = "Allow virtual network access for the destination VNet."
  type        = bool
  default     = true
}

variable "allow_gateway_transit_src" {
  description = "Allow gateway transit for the source VNet."
  type        = bool
  default     = false
}

variable "allow_gateway_transit_dest" {
  description = "Allow gateway transit for the destination VNet."
  type        = bool
  default     = false
}

variable "use_remote_gateways_src" {
  description = "Use remote gateways for the source VNet."
  type        = bool
  default     = false
}

variable "use_remote_gateways_dest" {
  description = "Use remote gateways for the destination VNet."
  type        = bool
  default     = false
}

variable "peering_name_prefix" {
  description = "Prefix for the peering name."
  type        = string
  default     = "vnet-peering"
}
