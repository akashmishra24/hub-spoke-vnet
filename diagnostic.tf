data "azurerm_log_analytics_workspace" "logs" {
  name = "DefaultWorkspace-4f25621d-2baf-49dd-9803-3a4b2a104798-EUS2"
  resource_group_name = "defaultresourcegroup-eus2"
}

resource "azurerm_monitor_diagnostic_setting" "nsg-Hub" {
  name               = "diag-hub-${var.prefix}-nsg"
  target_resource_id = azurerm_network_security_group.nsg-hub.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logs.id
  depends_on = [azurerm_network_security_group.nsg-hub]
  

log {
    category = "NetworkSecurityGroupEvent"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }
  log {
    category = "NetworkSecurityGroupRuleCounter"
    enabled = true

    retention_policy {
      enabled =true
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "vnet-hub-diag" {
  name               = "diag-hub-${var.prefix}-vnet"
  target_resource_id = azurerm_virtual_network.hub-vnet.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logs.id
  depends_on = [azurerm_virtual_network.hub-vnet]
  

log {
  category = "VMProtectionAlerts"
}

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
    }
  }
}