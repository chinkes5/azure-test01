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

resource "azurerm_subnet" "myTFsubnet1" {
  name                 = "${azurerm_virtual_network.vnet.name}-subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnets
}

resource "azurerm_network_security_group" "myTFsecurityGroup" {
  name                = "https-in-only-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    createdBy   = var.createdBy
    createdDate = timestamp()
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "myTF-SGA" {
  subnet_id                 = azurerm_subnet.myTFsubnet1.id
  network_security_group_id = azurerm_network_security_group.myTFsecurityGroup.id
}
