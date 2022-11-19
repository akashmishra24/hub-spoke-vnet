
resource "azurerm_virtual_network_peering" "peer-hub-2-spoke" {
  name                      = "peer-hub-2-spoke"
  resource_group_name       = data.azurerm_resource_group.hub-rg.name
  virtual_network_name      = azurerm_virtual_network.hub-vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke-vnet.id 
}
resource "azurerm_virtual_network_peering" "peer-spoke-2-hub" {
  name                      = "peer-spoke-2-hub"
  resource_group_name       = data.azurerm_resource_group.spoke-rg.name
  virtual_network_name      = azurerm_virtual_network.spoke-vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub-vnet.id 
}