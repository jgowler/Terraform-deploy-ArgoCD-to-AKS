### Resource group:
data "azurerm_resource_group" "project" {
  name = var.resource_group_name
}
### SSH Key
resource "local_sensitive_file" "ssh_private_key" {
  content         = module.SSHKeys.ssh_private_key
  file_permission = "0600"
  filename        = "${path.module}/SSHKeys/aks_ssh_key"
}
### Modules:
module "Network" {
  source              = "./Modules/Network"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  common_tags         = var.common_tags
}

module "SSHKeys" {
  source = "./Modules/SSHKeys"
}

module "KeyVault" {
  source               = "./Modules/KeyVault"
  resource_group_name  = data.azurerm_resource_group.project.name
  location             = data.azurerm_resource_group.project.location
  tenant_id            = var.tenant_id
  vnet_name            = module.Network.vnet_name
  cluster_principal_id = module.AKS.cluster_principal_id
}

module "ApplicationGateway" {
  source              = "./Modules/ApplicationGateway"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  appgw_subnet_id     = module.Network.appgw_subnet_id
  vnet_name           = module.Network.vnet_name
  appgw_public_ip     = module.Network.appgw_public_ip
  common_tags         = var.common_tags
}

module "AKS" {
  source              = "./Modules/AKS"
  common_tags         = var.common_tags
  aks_subnet_id       = module.Network.aks_subnet_id
  appgw_id            = module.ApplicationGateway.appgw_id
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  ssh_public_key      = module.SSHKeys.ssh_public_key
}

module "Identities" {
  source = "./Modules/Identities"
  principal_ids = [
    module.AKS.cluster_principal_id,
    module.ApplicationGateway.appgw_identity_principal_id
  ]
  role_assignments = {
    "Contributer" = [
      module.Network.vnet_id,
      module.Network.aks_subnet_id,
      module.Network.appgw_subnet_id
    ]
    "Reader" = [
      module.KeyVault.keyvault_id
    ]
  }
}

module "ArgoCD" {
  source      = "./Modules/ArgoCD"
  kubeconfig  = module.AKS.kube_config
  argocd_repo = "./Modules/ArgoCD/Charts/argo-cd"
  namespace   = "argocd"
  appgw_public_ip_addr = module.Network.appgw_public_ip_addr
}