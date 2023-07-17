output "azurerm_subnet_name" {
  value = azurerm_subnet.network-subnet
}

output "network_security_group_name" {
  value = azurerm_network_security_group.nsg
}

output "virtual_network_name" {
  value = azurerm_virtual_network.network
}