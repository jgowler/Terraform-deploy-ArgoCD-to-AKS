output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config[0]
  sensitive = true
}
output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}
output "cluster_location" {
  value = azurerm_kubernetes_cluster.aks_cluster.location
}
output "aks_service_principal" {
  value = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}
output "azurerm_virtual_network" {
  value = azurerm_virtual_network.aks_vnet.name
}
output "azurerm_subnet" {
  value = azurerm_subnet.aks_subnet.name
}
output "azurerm_public_ip" {
  value = azurerm_public_ip.ApplicationGateway.id
}
output "appgw_subnet" {
  value = azurerm_subnet.appgw_subnet.id
}
output "vnet_id" {
  value = azurerm_virtual_network.aks_vnet.id
}
output "aks_subnet_id" {
  value = azurerm_subnet.aks_subnet.id
}
