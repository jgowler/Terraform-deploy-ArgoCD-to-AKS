output "appgw_uai_id" {
  value = azurerm_user_assigned_identity.appgwuai.id
}
output "aks_contributor_vnet_id" {
  description = "Role assignment ID for AKS Contributor on VNet"
  value       = azurerm_role_assignment.aks_contributor_vnet.id
}

output "aks_contributor_aks_subnet_id" {
  description = "Role assignment ID for AKS Contributor on AKS Subnet"
  value       = azurerm_role_assignment.aks_contributor_aks_subnet.id
}

output "aks_contributor_appgw_subnet_id" {
  description = "Role assignment ID for AKS Contributor on AppGW Subnet"
  value       = azurerm_role_assignment.aks_contributor_appgw_subnet.id
}

output "appgw_contributor_vnet_id" {
  description = "Role assignment ID for AppGW Contributor on VNet"
  value       = azurerm_role_assignment.appgw_contributor_vnet.id
}

output "appgw_contributor_aks_subnet_id" {
  description = "Role assignment ID for AppGW Contributor on AKS Subnet"
  value       = azurerm_role_assignment.appgw_contributor_aks_subnet.id
}

output "appgw_contributor_appgw_subnet_id" {
  description = "Role assignment ID for AppGW Contributor on AppGW Subnet"
  value       = azurerm_role_assignment.appgw_contributor_appgw_subnet.id
}

output "aks_reader_keyvault_id" {
  description = "Role assignment ID for AKS Reader on Key Vault"
  value       = azurerm_role_assignment.aks_reader_keyvault.id
}

output "appgw_reader_keyvault_id" {
  description = "Role assignment ID for AppGW Reader on Key Vault"
  value       = azurerm_role_assignment.appgw_reader_keyvault.id
}
