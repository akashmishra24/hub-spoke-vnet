resource "azurerm_virtual_network" "hub-vnet" {
  name                = "vnet-hub-${var.prefix}-weu-01"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.hub-rg.name
  address_space       = var.hub_address_space
  dns_servers         = var.dns_server_ip
  tags = {
    "Critical"    = "Yes"
    "Solution"    = "Vnet"
    "Costcenter"  = "It"
    "Environment" = "Hub"
    "Location"    = "Weu"
  }
}

resource "azurerm_network_security_group" "nsg-hub" {
  name                = "nsg-hub-${var.prefix}-01"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.hub-rg.name
  security_rule {
    name                       = "allow-rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 3389
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

data "azurerm_resource_group" "network_watcher_rg" {
  name = "NetworkWatcherRG"
}

data "azurerm_network_watcher" "network-watcher-hub" {
  name = "NetworkWatcher_eastus2"
  resource_group_name = data.azurerm_resource_group.network_watcher_rg.name
}

resource "azurerm_subnet" "firewall-subnet" {
  name                 = "AzureFirewallSubnet" ##can also be AzureFirewallManagementSubnet
  resource_group_name  = data.azurerm_resource_group.hub-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.hub_fw_subnet_cidr
}

resource "azurerm_subnet" "hub-subnet" {
  name                 = "Hub-Subnet"
  resource_group_name  = data.azurerm_resource_group.hub-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.hub_subnet_cidr
}

resource "azurerm_subnet" "hub_bastion-subnet" {
  name                 = "Hub-Bastion-Subnet"
  resource_group_name  = data.azurerm_resource_group.hub-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.hub_bastion_subnet_cidr
}