resource "azurerm_virtual_network" "spoke-vnet" {
  name                = "vnet-prod-${var.prefix}-weu-01"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.spoke-rg.name
  address_space       = var.spoke_address_space
  dns_servers         = var.dns_server_ip
 tags = {
    "Critical"    = "Yes"
    "Solution"    = "Vnet"
    "Costcenter"  = "It"
    "Environment" = "Prod"
    "Location"    = "Weu"
  }
}

resource "azurerm_subnet" "spoke-subnet" {
  name                 = "Spoke-Subnet"
  resource_group_name  = data.azurerm_resource_group.spoke-rg.name
  virtual_network_name = azurerm_virtual_network.spoke-vnet.name
  address_prefixes     = var.spoke_subnet_cidr
}

resource "azurerm_subnet" "spoke-int_subnet" {
  name                 = "Spoke-Int-Subnet"
  resource_group_name  = data.azurerm_resource_group.spoke-rg.name
  virtual_network_name = azurerm_virtual_network.spoke-vnet.name
  address_prefixes     = var.spoke_int_subnet_cidr
}