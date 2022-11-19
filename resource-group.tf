data "azurerm_resource_group" "hub-rg" {
  name = "HubRG"
}

data "azurerm_resource_group" "spoke-rg" {
  name = "SpokeRG1"
}