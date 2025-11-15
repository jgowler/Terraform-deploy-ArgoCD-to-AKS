terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.38.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.0"
    }
  }
}

provider "azurerm" {

  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
provider "kubernetes" {
  host                   = module.AKS.kube_config.host
  client_certificate     = base64decode(module.AKS.kube_config.client_certificate)
  client_key             = base64decode(module.AKS.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.AKS.kube_config.cluster_ca_certificate)
}
provider "helm" {
  kubernetes = {
    host                   = module.AKS.kube_config.host
    client_certificate     = base64decode(module.AKS.kube_config.client_certificate)
    client_key             = base64decode(module.AKS.kube_config.client_key)
    cluster_ca_certificate = base64decode(module.AKS.kube_config.cluster_ca_certificate)
  }
}
