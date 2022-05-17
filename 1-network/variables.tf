variable "name_prefix" {
  description = "String to be added in front of all Azure object names"
  type        = string
}

variable "location" {
  description = "Azure Location"
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group"
  type        = string
}

variable "cidr_vnet" {
  description = "CIDR block for virtual network"
  type        = string
  default     = "192.168.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR block for subnet where we install resources"
  type        = string
  default     = "192.168.1.0/24"
}
