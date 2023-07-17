variable "rgroup_name" {

}

variable "rgroup_location" {

}

variable "recovery_services_vault" {
  type                  = map(string)
  default               = {
    recovery_vault_name = "myrecovery-vault"
    recovery_sku        = "Standard"
  }
 }

variable "storage_account_tier" {
  default = "Standard"
}

variable "storage_account_replication_type" {
  default = "LRS"
}

variable "subnet_id" {

}
