resource "azurerm_resource_group" "rgroup" {
  name                = var.rgroup-name
  location            = var.rgroup-location
  
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "shivank.khanna"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}