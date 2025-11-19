terraform {
  required_version = ">= 1.5.0, < 2.0.0"
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
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.6.1"
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
  alias                  = "aks"
  host                   = module.AKS.kube_admin_config["host"]
  client_certificate     = base64decode(module.AKS.kube_admin_config["client_certificate"])
  client_key             = base64decode(module.AKS.kube_admin_config["client_key"])
  cluster_ca_certificate = base64decode(module.AKS.kube_admin_config["cluster_ca_certificate"])
}

provider "helm" {
  alias = "aks"
  kubernetes = {
    host                   = module.AKS.kube_admin_config["host"]
    client_certificate     = base64decode(module.AKS.kube_admin_config["client_certificate"])
    client_key             = base64decode(module.AKS.kube_admin_config["client_key"])
    cluster_ca_certificate = base64decode(module.AKS.kube_admin_config["cluster_ca_certificate"])
  }
}
