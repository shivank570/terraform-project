resource "azurerm_public_ip" "public_ip" {
  name                       = "PublicIPForLB"
  location                   = var.rgroup-location
  resource_group_name        = var.rgroup-name
  allocation_method          = "Static"
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_lb" "linux_loadbalancer" {
  name                     = "linux_lb"
  location                 = var.rgroup-location
  resource_group_name      = var.rgroup-name
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
   tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_lb_backend_address_pool" "address_pool" {
  loadbalancer_id = azurerm_lb.linux_loadbalancer.id
  name            = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "backend_pool_assoc" {
  count                   = var.nb_count
  network_interface_id    = var.linux-nic-id[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.address_pool.id
  ip_configuration_name   = "${replace(var.linux-vm-name[0], "vm1", "vm")}-ipconfig1${format("%1d", count.index + 1)}"
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.linux_loadbalancer.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

