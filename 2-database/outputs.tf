output "address" {
  value = azurerm_private_endpoint._.private_service_connection[0].private_ip_address
}  

output "port" {
  value = 3306
}
