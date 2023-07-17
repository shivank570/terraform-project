resource "azurerm_virtual_network" "network" {
  name                = "N01581230-VNET"
  location            = var.rgroup-location
  resource_group_name = var.rgroup-name
  address_space       = var.network-space

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_subnet" "network-subnet" {
  name                 = "N01581230-SUBNET"
  resource_group_name  = var.rgroup-name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = var.subnet-address-space
}

resource "azurerm_network_security_group" "nsg" {
  name                = "N01581230-SG"
  location            = var.rgroup-location
  resource_group_name = var.rgroup-name

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule3"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule4"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg" {  
  subnet_id                 = azurerm_subnet.network-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
