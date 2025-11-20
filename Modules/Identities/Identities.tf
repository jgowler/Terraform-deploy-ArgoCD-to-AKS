### AppGW Identity:
resource "azurerm_user_assigned_identity" "appgwuai" {
  name                = "appgw-uai"
  resource_group_name = var.resource_group_name
  location            = var.location
}

### Grant permissions:
resource "azurerm_role_assignment" "aks_contributor_vnet" {
  principal_id         = var.cluster_principal_id
  role_definition_name = "Contributor"
  scope                = var.vnet_id
}

resource "azurerm_role_assignment" "aks_contributor_aks_subnet" {
  principal_id         = var.cluster_principal_id
  role_definition_name = "Contributor"
  scope                = var.aks_subnet_id
}

resource "azurerm_role_assignment" "aks_contributor_appgw_subnet" {
  principal_id         = var.cluster_principal_id
  role_definition_name = "Contributor"
  scope                = var.appgw_subnet_id
}

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

resource "azurerm_role_assignment" "aks_reader_keyvault" {
  principal_id         = var.cluster_principal_id
  role_definition_name = "Reader"
  scope                = var.keyvault_id
}

resource "azurerm_role_assignment" "appgw_reader_keyvault" {
  principal_id         = azurerm_user_assigned_identity.appgwuai.principal_id
  role_definition_name = "Reader"
  scope                = var.keyvault_id
}

resource "azurerm_role_assignment" "agic_appgw_contributor" {
  scope                = var.appgw_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.appgwuai.principal_id
}

resource "azurerm_role_assignment" "agic_rg_reader" {
  scope                = var.resource_group_id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.appgwuai.principal_id
}
