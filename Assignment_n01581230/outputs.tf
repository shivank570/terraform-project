output "rg-network-name" {
  value = module.rgroup.az-rgroup-name.name
}

output "rg-network-location" {
  value = module.rgroup.az-rgroup-location.location
}

output "azurerm_subnet_name" {
  value = module.network.azurerm_subnet_name.name
}

output "virtual_network_name" {
  value = module.network.virtual_network_name.name
}

output "VirtualNetwork-Sapce" {
  value = module.network.virtual_network_name.address_space
}

output "network_security_group_name1" {
  value = module.network.network_security_group_name.name
}

output "VM-Win-Hostname" {
  value = module.vmwindows.VM-Win-Hostname
}

output "PublicIP-Win" {
  value = module.vmwindows.PublicIP-Win
}

output "PrivateIP-Win" {
  value = module.vmwindows.PrivateIP-Win
}

output "linux-vm-private-ip" {
  value = module.vmlinux.linux-vm-private-ip
}

output "linux-vm-public-ip" {
  value = module.vmlinux.linux-vm-public-ip
}

output "linux_virtual_machine" {
  value = module.vmlinux.linux_virtual_machine
}

output "linux-vm-hostname" {
  value = module.vmlinux.linux-vm-hostname
}

output "log_analytics_workspace_name" {
  value = module.common.log_analytics_workspace_name.name
}

output "recovery_vault_name" {
  value = module.common.recovery_vault_name.name
}

output "storage_account_name" {
  value = module.common.storage_account_name.name
}

output "db_name" {
  value = module.database.db_name.name
}