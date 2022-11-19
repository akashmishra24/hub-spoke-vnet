terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-centralindia"
    storage_account_name = "csg1003bffd9933fa78"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

#Configure the Azure Provider
provider "azurerm" {
  features {}
}