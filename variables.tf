variable "resource_group_name" {
  description = "Resource Group in subscription"
  type        = string
}
variable "subscription_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "clustername" {
  type = string
}
variable "argocd_repo" {
  type = string
}
variable "common_tags" {
  type = map(string)
  default = {
    "Project"      = "ArgoCD"
    "CreatedUsing" = "Terraform"
    "DeployedBy"   = "github.com/jgowler"
  }
}