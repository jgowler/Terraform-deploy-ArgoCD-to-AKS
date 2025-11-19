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
principal_id         = var.appgw_principal_id
role_definition_name = "Contributor"
scope                = var.vnet_id
}

resource "azurerm_role_assignment" "appgw_contributor_aks_subnet" {
principal_id         = var.appgw_principal_id
role_definition_name = "Contributor"
scope                = var.aks_subnet_id
}

resource "azurerm_role_assignment" "appgw_contributor_appgw_subnet" {
principal_id         = var.appgw_principal_id
role_definition_name = "Contributor"
scope                = var.appgw_subnet_id
}

resource "azurerm_role_assignment" "aks_reader_keyvault" {
principal_id         = var.cluster_principal_id
role_definition_name = "Reader"
scope                = var.keyvault_id
}

resource "azurerm_role_assignment" "appgw_reader_keyvault" {
principal_id         = var.appgw_principal_id
role_definition_name = "Reader"
scope                = var.keyvault_id
}
