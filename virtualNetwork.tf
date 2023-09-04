resource "azurerm_virtual_network" "vnet" {
  name                = "myTFVirtualNetwork"
  address_space       = var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    createdBy   = var.createdBy
    createdDate = timestamp()
    environment = var.environment
  }
}