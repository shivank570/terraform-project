resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                   = "LogAnalyticsWorkspace"
  location               = var.rgroup_location
  resource_group_name    = var.rgroup_name
  sku                    = "PerGB2018"
  retention_in_days      = 30
  
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                  = var.recovery_services_vault["recovery_vault_name"]
  location              = var.rgroup_location
  resource_group_name   = var.rgroup_name
  sku                   = var.recovery_services_vault["recovery_sku"]
  soft_delete_enabled   = true
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "tfstaten1230sa"
  location                 = var.rgroup_location
  resource_group_name      = var.rgroup_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
