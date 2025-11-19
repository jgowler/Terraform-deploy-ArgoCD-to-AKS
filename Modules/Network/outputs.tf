output "vnet_id" {
  value = azurerm_virtual_network.vnet-aks.id
}
output "vnet_name" {
  value = azurerm_virtual_network.vnet-aks.name
}
output "aks_subnet_id" {
  value = azurerm_subnet.subnet-aks.id
}
output "aks_subnet_name" {
  value = azurerm_subnet.subnet-aks.name
}
output "appgw_subnet_id" {
  value = azurerm_subnet.subnet-appgw.id
}
output "appgw_subnet_name" {
  value = azurerm_subnet.subnet-appgw.name
}
output "appgw_public_ip" {
  value = azurerm_public_ip.pip.id
}
output "appgw_public_ip_addr" {
  value = azurerm_public_ip.pip.ip_address
}