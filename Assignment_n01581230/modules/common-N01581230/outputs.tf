output "log_analytics_workspace_name" {
    value  = azurerm_log_analytics_workspace.log_analytics_workspace
}
output "recovery_vault_name" {
    value = azurerm_recovery_services_vault.recovery_vault
}
output "storage_account_name" {
    value = azurerm_storage_account.storage_account
}
output "storage_account_key" {
    value = azurerm_storage_account.storage_account
}