resource "azurem_public_ip" "myTF-publicIP" {
  name                = "myTF-IP01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"

  tags = {
    createdBy   = var.createdBy
    createdDate = timestamp()
    environment = var.environment
  }
}

resource "azurerm_network_interface" "myTF-NIC01" {
  name                = "myTF-NIC01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "myTF-NIC01-ipconfig"
    subnet_id                     = azurerm_subnet.myTFsubnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurem_public_ip.myTF-publicIP.id
  }

  tags = {
    createdBy   = var.createdBy
    createdDate = timestamp()
    environment = var.environment
  }
}