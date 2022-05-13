variable "name_prefix" {
  description = "String to be added in front of all Azure object names"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}
