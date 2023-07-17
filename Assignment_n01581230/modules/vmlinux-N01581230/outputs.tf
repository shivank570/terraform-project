output "linux-vm-hostname" {
  value = azurerm_linux_virtual_machine.vm-linux[*].name
}

output "linux-vm-id" {
  value = azurerm_linux_virtual_machine.vm-linux[*].id
}

output "liunx-vm-FQDN" {
  value = [azurerm_public_ip.vm-public-ip[*].fqdn]
}

output "linux-vm-private-ip" {
  value = [azurerm_linux_virtual_machine.vm-linux[*].private_ip_address]

}

output "linux-vm-public-ip" {
  value = azurerm_linux_virtual_machine.vm-linux[*].public_ip_address
}

output "linux_availability_set" {
  value = azurerm_availability_set.avail_set.name
}

output "linux_virtual_machine" {
  value = [azurerm_linux_virtual_machine.vm-linux[*].name]
}

output "linux_domain" {
  value = [azurerm_public_ip.vm-public-ip[*].domain_name_label]
}

output "nic_id" {
  value = [azurerm_network_interface.vm-net-interface[*].id]

}