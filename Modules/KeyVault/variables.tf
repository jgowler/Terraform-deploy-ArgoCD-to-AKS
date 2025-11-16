variable "resource_group_name" {
  description = "Resource Group in subscription"
  type        = string
}
variable "location" {
  type = string
}
variable "common_tags" {
  type = map(string)
}
variable "tenant_id" {
  type = string
}
variable "aks_service_principal" {
  type = string
}
variable "argocd_admin" {
  type = string
}