variable "appgw_name" {
  description = "Name of the Application Gateway"
  type        = string
}

variable "location" {
  description = "Location for the Application Gateway"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the Application Gateway"
  type        = string
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

variable "capacity" {
  description = "Capacity for the Application Gateway"
  type        = number
}

variable "subnet_id" {
  description = "ID of the subnet for the Application Gateway"
  type        = string
}

variable "subnet_cidr" {
  description = "ID of the subnet for the Application Gateway"
  type        = string
}

variable "public_ip_id" {
  description = "ID of the public IP address for the Application Gateway"
  type        = string
}

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

variable "rule_set_type" {
  description = "The rule set type for the WAF, typically 'OWASP'."
  type        = string
  default     = "OWASP"
}

variable "rule_set_version" {
  description = "The version of the OWASP rule set."
  type        = string
  default     = "3.2"
}

variable "tags" {
  description = "Tags to be assigned to the Application Gateway"
  type        = map(string)  # or any other type as per your requirement
  default     = {}           # Optional: You can set a default value
}
