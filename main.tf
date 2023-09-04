# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.5.0"

  # Save Terraform state in Azure
  backend "azurerm" {
    storage_account_name = "chinkesterraformstorage"
    container_name       = "statefiles"
    key                  = "Azure-Test01.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "westus2"
}
