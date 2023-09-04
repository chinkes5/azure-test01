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
  subscription_id = "823e306b-2238-4968-9187-d32ee1afad8a"
  # https://stackoverflow.com/questions/57892557/terraform-azure-as-a-provider-and-limited-access-account
  # Getting error with the subscription from RSI as I'm not king of all I survey...
  skip_provider_registration = "true"
}
