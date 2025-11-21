output "appgw_uai_id" {
  value = azurerm_user_assigned_identity.appgwuai.id
}
output "appgw_uai_id_pi" {
  value = azurerm_user_assigned_identity.appgwuai.principal_id
}
output "appgw_contributor_vnet_id" {
  description = "Role assignment ID for AppGW Contributor on VNet"
  value       = azurerm_role_assignment.appgw_contributor_vnet.id
}
output "appgw_contributor_appgw_subnet_id" {
  description = "Role assignment ID for AppGW Contributor on AppGW Subnet"
  value       = azurerm_role_assignment.appgw_contributor_appgw_subnet.id
}
output "appgw_reader_keyvault_id" {
  description = "Role assignment ID for AppGW Reader on Key Vault"
  value       = azurerm_role_assignment.appgw_reader_keyvault.id
}
