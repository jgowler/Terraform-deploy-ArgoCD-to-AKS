output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config[0]
  sensitive = true
}
output "kube_admin_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_admin_config[0]
  sensitive = true
}
output "kube_host" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host
}
output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}
output "cluster_location" {
  value = azurerm_kubernetes_cluster.aks_cluster.location
}
output "cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
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
output "appgw_subnet" {
  value = azurerm_subnet.appgw_subnet.id
}
output "vnet_id" {
  value = azurerm_virtual_network.aks_vnet.id
}
output "aks_subnet_id" {
  value = azurerm_subnet.aks_subnet.id
}
