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
  source              = "./Modules/KeyVault"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  tenant_id           = var.tenant_id
  vnet_name           = module.Network.vnet_name
  appgw_uai_id        = module.Identities.appgw_uai_id
  appgw_uai_id_pi     = module.Identities.appgw_uai_id_pi
}

module "ApplicationGateway" {
  source              = "./Modules/ApplicationGateway"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  appgw_uai_id = [
    module.Identities.appgw_uai_id
  ]
  appgw_subnet_id = module.Network.appgw_subnet_id
  vnet_name       = module.Network.vnet_name
  appgw_public_ip = module.Network.appgw_public_ip
  common_tags     = var.common_tags
}

module "AKS" {
  source        = "./Modules/AKS"
  common_tags   = var.common_tags
  aks_subnet_id = module.Network.aks_subnet_id
  appgw_id      = module.ApplicationGateway.appgw_id
  appgw_uai_id = [
    module.Identities.appgw_uai_id
  ]
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  ssh_public_key      = module.SSHKeys.ssh_public_key
}

module "Identities" {
  source              = "./Modules/Identities"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  appgw_id            = module.ApplicationGateway.appgw_id
  appgw_principal_id  = module.ApplicationGateway.appgw_principal_id
  cluster_identity_pi = module.AKS.cluster_identity_pi
  agic_principal_id   = module.AKS.agic_principal_id
  resource_group_id   = data.azurerm_resource_group.project.id
  vnet_id             = module.Network.vnet_id
  aks_subnet_id       = module.Network.aks_subnet_id
  appgw_subnet_id     = module.Network.appgw_subnet_id
  keyvault_id         = module.KeyVault.keyvault_id
}

module "ArgoCD" {
  source               = "./Modules/ArgoCD"
  kubeconfig           = module.AKS.kube_config
  argocd_repo          = "./Modules/ArgoCD/Charts/argo-cd"
  namespace            = "argocd"
  appgw_public_ip_addr = module.Network.appgw_public_ip_addr
}