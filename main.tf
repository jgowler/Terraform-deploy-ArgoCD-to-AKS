data "azurerm_resource_group" "project" {
  name = var.resource_group_name
}
module "KeyVault" {
  source                = "./Modules/KeyVault"
  resource_group_name   = data.azurerm_resource_group.project.name
  location              = data.azurerm_resource_group.project.location
  common_tags           = var.common_tags
  tenant_id             = var.tenant_id
  aks_service_principal = module.AKS.aks_service_principal
}
module "AKS" {
  source              = "./Modules/AKS"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  clustername         = var.clustername
  common_tags         = var.common_tags
}
module "Namespace" {
  source              = "./Modules/Namespace"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  common_tags         = var.common_tags
}
# Continue with setting up ArgoCD module
module "ArgoCD" {
  source              = "./Modules/ArgoCD"
  kubeconfig          = module.AKS.kube_config
  namespace           = module.Namespace.Namespace
  admin_secret        = module.KeyVault.admin_secret
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  common_tags         = var.common_tags
}
module "Ingress" {
  source              = "./Modules/Ingress"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  common_tags         = var.common_tags
}
module "GitOps" {
  source              = "./Modules/GitOps"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  common_tags         = var.common_tags
}