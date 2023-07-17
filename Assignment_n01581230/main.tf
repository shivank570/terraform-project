# module for resourse group

module "rgroup" {
  source          = "./modules/rgroup-N01581230"
  rgroup-name     = "N01581230-RG"
  rgroup-location = "canadacentral"
}

# module for network

module "network" {
  source          = "./modules/network-N01581230"
  rgroup-name     = module.rgroup.az-rgroup-name.name
  rgroup-location  = module.rgroup.az-rgroup-location.location
  depends_on      = [
    module.rgroup
  ]
}

# module for common

module "common" {
  source          = "./modules/common-N01581230"
  rgroup_name     = module.rgroup.az-rgroup-name.name
  rgroup_location = module.rgroup.az-rgroup-location.location
  subnet_id       = module.network.azurerm_subnet_name
  depends_on      = [
    module.rgroup
  ]
}

# module for linux virtual machine

module "vmlinux" {
  source            = "./modules/vmlinux-N01581230"
  nb_count          = "3"
  linux-vm-name     = "vmlinux-N01581230"
  rgroup-name       = module.rgroup.az-rgroup-name.name
  rgroup-location   = module.rgroup.az-rgroup-location.location
  subnet_id         = module.network.azurerm_subnet_name.id
  depends_on        = [
    module.rgroup,
    module.common,
    module.network
  ]
  storage_account_name = module.common.storage_account_name.name
  storage_account_key  = module.common.storage_account_key
  storage_act          = module.common.storage_account_name
}

# module for windows virtual machine

module "vmwindows" {
  source         = "./modules/windows-N01581230"
  windows_name   = {
    N01581230-vm1 = "Standard_B1s"
    N01581230-vm2 = "Standard_B1ms"
  }
  win_nb_count     = "1"
  subnet_id        = module.network.azurerm_subnet_name.id
  rgroup-name      = module.rgroup.az-rgroup-name.name
  rgroup-location  = module.rgroup.az-rgroup-location.location
  storage_act      = module.common.storage_account_name
  depends_on       = [
    module.rgroup,
    module.common,
    module.network
  ]
}

# module for data disk

module "datadisk" {
  source                   = "./modules/datadisk-N01581230"
  rgroup-name              = module.rgroup.az-rgroup-name.name
  rgroup-location          = module.rgroup.az-rgroup-location.location
  windows_name             = module.vmwindows.VM-Win-Hostname
  win_virtual_machine_id   = module.vmwindows.VM-Win
  linux-vm-name            = module.vmlinux.linux-vm-hostname
  linux_virtual_machine_id = module.vmlinux.linux-vm-id
  depends_on               = [
    module.rgroup,
    module.vmlinux,
    module.vmwindows
  ]
}

# module for load balancer

module "loadbalancer" {
  source           = "./modules/loadbalancer-N01581230"
  rgroup-name      = module.rgroup.az-rgroup-name.name
  rgroup-location  = module.rgroup.az-rgroup-location.location
  linux_public_ip  = module.vmlinux.linux-vm-public-ip
  linux-nic-id     = module.vmlinux.nic_id[0]
  nb_count         = "1"
  linux-vm-name    = module.vmlinux.linux-vm-hostname
  subnet_id        = module.network.azurerm_subnet_name
  depends_on       = [
    module.rgroup,
    module.vmlinux,
  ]
}

# module for database

module "database" {
  source      = "./modules/database-N01581230"
  rgroup-name     = module.rgroup.az-rgroup-name.name
  rgroup-location = module.rgroup.az-rgroup-location.location
  depends_on = [
    module.rgroup
  ]
}