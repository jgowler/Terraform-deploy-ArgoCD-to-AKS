data "azurerm_resource_group" "project" {
  name = var.resource_group_name
}
resource "tls_private_key" "aks-ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "aks-ssh-key" {
  filename        = "${path.module}/aks-ssh-key"
  content         = tls_private_key.aks-ssh-key.private_key_openssh
  file_permission = "0600"
}
resource "azurerm_user_assigned_identity" "agic_identity" {
  name                = "agic-identity"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
}
module "KeyVault" {
  source                = "./Modules/KeyVault"
  resource_group_name   = data.azurerm_resource_group.project.name
  location              = data.azurerm_resource_group.project.location
  argocd_admin          = module.ArgoCD.argocd_admin_password
  common_tags           = var.common_tags
  tenant_id             = var.tenant_id
  aks_service_principal = module.AKS.aks_service_principal
}
module "AKS" {
  source              = "./Modules/AKS"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  ssh_public_key      = tls_private_key.aks-ssh-key.public_key_openssh
  clustername         = var.clustername
  common_tags         = var.common_tags
}
module "Namespace" {
  source              = "./Modules/Namespace"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  common_tags         = var.common_tags
}
module "ArgoCD" {
  source              = "./Modules/ArgoCD"
  kubeconfig          = module.AKS.kube_config
  namespace           = module.Namespace.Namespace
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  argocd_repo         = var.argocd_repo
  common_tags         = var.common_tags
}
module "AGIC" {
  depends_on = [
    module.ApplicationGateway
  ]

  source                 = "./Modules/AGIC"
  resource_group_name    = data.azurerm_resource_group.project.name
  agic_service_principal = azurerm_user_assigned_identity.agic_identity.principal_id
  appgw_subnet           = module.AKS.appgw_subnet
  repository             = var.repository
  appgw_name             = module.ApplicationGateway.appgw_name
  aks_service_principal  = module.AKS.aks_service_principal
}
module "ApplicationGateway" {
  source                 = "./Modules/ApplicationGateway"
  resource_group_name    = data.azurerm_resource_group.project.name
  location               = data.azurerm_resource_group.project.location
  aks_service_principal  = module.AKS.aks_service_principal
  agic_service_principal = azurerm_user_assigned_identity.agic_identity.principal_id
  vnet_name              = module.AKS.azurerm_virtual_network
  subnet_id              = module.AKS.appgw_subnet
  public_ip_id           = module.AKS.azurerm_public_ip
  common_tags            = var.common_tags
}
module "GitOps" {
  source              = "./Modules/GitOps"
  resource_group_name = data.azurerm_resource_group.project.name
  location            = data.azurerm_resource_group.project.location
  common_tags         = var.common_tags
}