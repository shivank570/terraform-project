resource "azurerm_availability_set" "window_avail_set" {
  name                         = var.win_avail_set
  location                     = var.rgroup-location
  resource_group_name          = var.rgroup-name
  platform_update_domain_count = 5
  tags = {
    environment = "prod"
  }
}

resource "azurerm_windows_virtual_machine" "window_vm" {
  name                = each.key
  computer_name       = each.key
  for_each            = var.windows_name
  resource_group_name = var.rgroup-name
  location            = var.rgroup-location
  size                = each.value
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
  winrm_listener {
    protocol = "Http"
  }
  network_interface_ids = [
    azurerm_network_interface.network-interface[each.key].id
  ]
  depends_on = [
    azurerm_availability_set.window_avail_set
  ]
  os_disk {
    name                 = each.key
    caching              = var.win-vm-os-disk-attr["los-disk-Caching"]
    storage_account_type = var.win-vm-os-disk-attr["los-storage-account-type"]
    disk_size_gb         = var.win-vm-os-disk-attr["los-disk-size"]
  }
  source_image_reference {
    publisher = var.win_vm_source_image_info["los-publisher"]
    offer     = var.win_vm_source_image_info["los-offer"]
    sku       = var.win_vm_source_image_info["los-sku"]
    version   = var.win_vm_source_image_info["los-version"]
  }

    boot_diagnostics {
    storage_account_uri = var.storage_act.primary_blob_endpoint
  }
}

resource "azurerm_network_interface" "network-interface" {
  for_each            = var.windows_name
  name                = "${each.key}-nic"
  location            = var.rgroup-location
  resource_group_name = var.rgroup-name
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }

  ip_configuration {
    name                          = "${each.key}-nic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip-N01581230-my[each.key].id

  }
}

resource "azurerm_public_ip" "public-ip-N01581230-my" {
  name                = each.key
  for_each            = var.windows_name
  resource_group_name = var.rgroup-name
  location            = var.rgroup-location
  allocation_method   = "Dynamic"
  domain_name_label   = "terraform-labs-${lower(replace(each.key, "/[^a-z0-9-]/", ""))}"
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_virtual_machine_extension" "extension" {
  for_each                   = var.windows_name
  name                       = "IaaSAntimalware"
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
  virtual_machine_id         = azurerm_windows_virtual_machine.window_vm[each.key].id

  settings = <<SETTINGS
    {
        "AntimalwareEnabled": true,
        "RealtimeProtectionEnabled": "true",
        "ScheduledScanSettings": {
            "isEnabled": "true",
            "day": "1",
            "time": "120",
            "scanType": "Quick"
            },
        "Exclusions": {
            "Extensions": "",
            "Paths": "",
            "Processes": ""
            }
    }
SETTINGS
}
