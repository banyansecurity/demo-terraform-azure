variable "name_prefix" {
  type        = string
  description = "String to be added in front of all AWS object names"
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the connector instance should be created"
}

variable "ssh_key_path" {
  type        = string
  description = "Path of your SSH key to upload to instance to allow management access"
}

variable "banyan_host" {
  type        = string
  description = "URL of the Banyan Command Center"
  default     = "https://team.console.banyanops.com/"
}

variable "banyan_api_key" {
  type        = string
  description = "API Key or Refresh Token generated from the Banyan Command Center console"
}

variable "connector_name" {
  type        = string
  description = "connector_name"
}