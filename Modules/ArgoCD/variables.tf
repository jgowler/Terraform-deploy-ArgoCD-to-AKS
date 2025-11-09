variable "resource_group_name" {
  description = "Resource Group in subscription"
  type        = string
}
variable "namespace" {
  description = "ArgoCD Namespace"
  type        = string
}
variable "location" {
  type = string
}
variable "common_tags" {
  type = map(string)
}
variable "kubeconfig" {
  type = string
}
variable "admin_secret" {
  type = string
}