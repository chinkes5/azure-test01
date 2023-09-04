data "azurerm_key_vault_secret" "storage_account_access_key" {
  name         = "TF-stateStorage"
  key_vault_id = "https://tf-statestorage.vault.azure.net/secrets/TF-stateStorage/5be27b1fed1143a68f30f778f3c43925"
}

# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.5.0"

  # Save Terraform state in Azure
  backend "azurerm" {
    storage_account_name = "chinkesterraformstorage"
    container_name       = "statefiles"
    key                  = "Azure-Test01.tfstate"
    access_key           = var.storage_account_access_key
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "westus2"
}
