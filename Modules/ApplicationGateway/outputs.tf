output "appgw_id" {
  value = azurerm_application_gateway.appgw.id
}
output "appgw_identity_principal_id" {
  value = azurerm_application_gateway.appgw.identity[0].principal_id
}