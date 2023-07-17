resource "azurerm_availability_set" "avail_set" {
  name                         = var.linux_avs
  location                     = var.rgroup-location
  resource_group_name          = var.rgroup-name
  platform_update_domain_count = 5
  platform_fault_domain_count  = var.nb_count
  tags = {
    environment = "prod"
  }                        
}

resource "azurerm_network_interface" "vm-net-interface" {
  count               = var.nb_count
  name                = "${var.linux-vm-name}-nic${format("%1d", count.index + 1)}"
  location            = var.rgroup-location
  resource_group_name = var.rgroup-name


  ip_configuration {
    name = "${var.linux-vm-name}1-ipconfig1${format("%1d", count.index + 1)}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.vm-public-ip[*].id, count.index + 1)
  }
  
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_public_ip" "vm-public-ip" {
  count                   = var.nb_count
  name                    = "${var.linux-vm-name}-pip${format("%1d", count.index + 1)}"
  resource_group_name     = var.rgroup-name
  location                = var.rgroup-location
  allocation_method       = "Dynamic"
  domain_name_label       = "domain1-${lower(replace(var.linux-vm-name, "/[^a-zA-Z0-9-]/", ""))}-${format("%1d", count.index + 1)}"
  idle_timeout_in_minutes = 30

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_linux_virtual_machine" "vm-linux" {
  count               = var.nb_count
  name                = "${var.linux-vm-name}${format("%1d", count.index + 1)}"
  computer_name       = "${var.linux-vm-name}${format("%1d", count.index + 1)}"
  resource_group_name = var.rgroup-name
  location            = var.rgroup-location
  size                = var.vm-size
  admin_username      = var.vm-admin-username
  availability_set_id = azurerm_availability_set.avail_set.id
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
  network_interface_ids = [
    element(azurerm_network_interface.vm-net-interface[*].id, count.index + 1)

  ]
  depends_on = [
    azurerm_availability_set.avail_set
  ]
  boot_diagnostics {
    storage_account_uri = var.storage_act.primary_blob_endpoint
  }
  admin_ssh_key {
    username   = var.vm-admin-username
    public_key = file(var.vm-admin-public-key-ssh)
  }
  os_disk {
    name                 = "${var.linux-vm-name}-os-disk${format("%1d", count.index + 1)}"
    caching              = var.vm-os-disk-attr["los-disk-caching"]
    storage_account_type = var.vm-os-disk-attr["los-storage-account-type"]
    disk_size_gb         = var.vm-os-disk-attr["los-disk-size"]
  }
  source_image_reference {
    publisher = var.vm-source_image_info["los-publisher"]
    offer     = var.vm-source_image_info["los-offer"]
    sku       = var.vm-source_image_info["los-sku"]
    version   = var.vm-source_image_info["los-version"]
  }
}

resource "azurerm_virtual_machine_extension" "linux-vm-network-watcher" {
  count                      = var.nb_count
  name                       = "network-watcher-${count.index + 1}"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm-linux[count.index].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }

  settings = <<SETTINGS
    {
      "xmlCfg": ""
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
    "storageAccountName": "${var.storage_account_name}",
    "storageAccountKey": "${var.storage_account_key.primary_access_key}"
    }
PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  count                      = var.nb_count
  name                       = "azure-monitor-${count.index + 1}"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm-linux[count.index].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
  settings = <<SETTINGS
    {
    }
SETTINGS
}