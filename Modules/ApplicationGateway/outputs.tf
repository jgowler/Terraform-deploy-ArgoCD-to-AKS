output "appgw_id" {
  value = azurerm_application_gateway.appgw.id
}
output "appgw_name" {
  value = azurerm_application_gateway.appgw.name
}
output "appgw_principal_id" {
  value = azurerm_application_gateway.appgw.identity[0].principal_id
}