### AppGW uai:
resource "azurerm_user_assigned_identity" "appgwuai" {
  name                = "appgw-uai"
  resource_group_name = var.resource_group_name
  location            = var.location
}

### Grant permissions to uai:
resource "azurerm_role_assignment" "appgw_contributor_vnet" {
  principal_id         = azurerm_user_assigned_identity.appgwuai.principal_id
  role_definition_name = "Contributor"
  scope                = var.vnet_id
}

resource "azurerm_role_assignment" "appgw_contributor_aks_subnet" {
  principal_id         = azurerm_user_assigned_identity.appgwuai.principal_id
  role_definition_name = "Contributor"
  scope                = var.aks_subnet_id
}

resource "azurerm_role_assignment" "appgw_contributor_appgw_subnet" {
  principal_id         = azurerm_user_assigned_identity.appgwuai.principal_id
  role_definition_name = "Contributor"
  scope                = var.appgw_subnet_id
}

resource "azurerm_role_assignment" "appgw_reader_keyvault" {
  principal_id         = azurerm_user_assigned_identity.appgwuai.principal_id
  role_definition_name = "Reader"
  scope                = var.keyvault_id
}
### Grant permissions to AGIC identity:
resource "azurerm_role_assignment" "agic_appgw_contributor" {
  principal_id         = var.agic_principal_id
  role_definition_name = "Contributor"
  scope                = var.appgw_id
}
resource "azurerm_role_assignment" "agic_rg_reader" {
  principal_id         = var.agic_principal_id
  role_definition_name = "Reader"
  scope                = var.resource_group_id
}
resource "azurerm_role_assignment" "agic_vnet_contributer" {
  principal_id         = var.agic_principal_id
  role_definition_name = "Contributor"
  scope                = var.vnet_id
}