resource "azurerm_virtual_machine" "myTF-VM" {
  name                = "myTF-VM"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vm_size             = "Standard_B1s"

  network_interface_ids = [azurerm_network_interface.myTF-NIC01.id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myTF-VM-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "myTF-VM"
    admin_username = "adminuser"
    admin_password = ""
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    createdBy   = var.createdBy
    createdDate = timestamp()
    environment = var.environment
  }
}