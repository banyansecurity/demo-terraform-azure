output "resource_group_name" {
  value      = azurerm_resource_group._.name
}

output "resource_group_location" {
  value      = azurerm_resource_group._.location
}


output "vnet_id" {
  value       = azurerm_virtual_network._.id
}

output "subnet_id" {
  value       = azurerm_subnet._.id
}