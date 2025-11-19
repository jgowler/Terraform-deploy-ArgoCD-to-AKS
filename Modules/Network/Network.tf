### Vnet:
resource "azurerm_virtual_network" "vnet-aks" {
  name = "vnet-aks"
  resource_group_name = var.resource_group_name
  location = var.location
  address_space = ["10.0.0.0/16"]
}
### Subnets:
resource "azurerm_subnet" "subnet-aks" {
  name = "subnet-aks"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-aks.name
  address_prefixes = ["10.0.3.0/24"]
}
resource "azurerm_subnet" "subnet-appgw" {
  name = "subnet-appgw"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-aks.name
  address_prefixes = ["10.0.1.0/27"]
}
### Public IP:
resource "azurerm_public_ip" "pip" {
  name                = "appgw-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.common_tags
}