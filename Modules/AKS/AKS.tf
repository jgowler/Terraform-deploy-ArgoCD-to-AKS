resource "azurerm_kubernetes_cluster" "this" {
  name                = var.clustername
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = var.common_tags
}