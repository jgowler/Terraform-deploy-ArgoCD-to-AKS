### Network
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "aksvnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["12.0.0.0/16"]

  tags = {
    DeployedBy = "Terraform",
    Type       = "VNET"
  }
}
resource "azurerm_subnet" "aks_subnet" {
  name                 = "akssubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["12.0.0.0/24"]
}
resource "azurerm_subnet" "appgw_subnet" {
  name                 = "appgwsubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["12.0.1.0/27"]
}

### AKS cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                              = var.clustername
  resource_group_name               = var.resource_group_name
  location                          = var.location
  dns_prefix                        = "akscluster"
  automatic_upgrade_channel         = "patch"
  role_based_access_control_enabled = true

  linux_profile {
    admin_username = "aks_admin"
    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.aks_law.id
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "calico"
  }
  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                 = "aksnodepool"
    vm_size              = "Standard_B2s"
    node_count           = 1
    auto_scaling_enabled = true
    min_count            = 1
    max_count            = 3
    type                 = "VirtualMachineScaleSets"
    os_sku               = "Ubuntu"
    vnet_subnet_id       = azurerm_subnet.aks_subnet.id

    node_labels = {
      "Environment"     = "Production"
      "OperatingSystem" = "LinuxUbuntu"
    }
    tags = var.common_tags
  }
}

resource "azurerm_public_ip" "ApplicationGateway" {
  name                = "pip-applicationgateway"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"

  tags = var.common_tags
}

### Log analytics workspace
resource "azurerm_log_analytics_workspace" "aks_law" {
  name                = "akslaw"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    DeployedBy = "Terraform",
    Type       = "LogAnalyticsWorkspace"
  }
}