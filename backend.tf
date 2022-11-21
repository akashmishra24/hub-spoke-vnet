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
  subscription_id = "4f25621d-2baf-49dd-9803-3a4b2a104798"
  tenant_id       = "52c068f1-73f9-4230-b1a5-1c2394b72c4b"
  client_id       = "ce51239c-416f-4bc5-95eb-6ef968a6f310"
  client_secret   = "Y7E8Q~HLHVrO5mtpyPIsT-fz9VND1AlaTIezHbZ3"
}
