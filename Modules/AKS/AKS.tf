resource "azurerm_kubernetes_cluster" "aks" {
  name                = "cluster-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_tier = "Free"
  automatic_upgrade_channel = "patch"
  dns_prefix = "test"

  default_node_pool {
    name       = "pool-default"
    vm_size    = "Standard_B2s"
    auto_scaling_enabled = true
    min_count = 1
    max_count = 3
    os_disk_size_gb = 40
    type  = "VirtualMachineScaleSets"
    vnet_subnet_id  = var.aks_subnet_id
    node_labels = {
        "environment"      = "test"
        "nodepools"       = "linux"
    }
    tags = var.common_tags
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "standard"
  }

  linux_profile {
    admin_username = "admintest"
    ssh_key {
      key_data = var.ssh_public_key
    }
  }
  ingress_application_gateway {
    gateway_id = var.appgw_id
  }
}