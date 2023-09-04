resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = var.location
  tags = {
    createdBy   = var.createdBy
    createdDate = timestamp()
    environment = var.environment
  }
}
