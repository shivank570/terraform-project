
output "window_avail_set" {
  value = azurerm_availability_set.window_avail_set
}

output "VM-Win" {
  value =  values(azurerm_windows_virtual_machine.window_vm)[*].id
}

output "VM-Win-Hostname" {
  value = [values(azurerm_windows_virtual_machine.window_vm)[*].name]
}

output "PublicIP-Win" {
  value = [values(azurerm_windows_virtual_machine.window_vm)[*].public_ip_address]
}

output "PrivateIP-Win" {
  value = [values(azurerm_windows_virtual_machine.window_vm)[*].private_ip_address]
}
