variable "resource_group" {
  description = "Resource Group in subscription"
  type        = string
}
variable "resource_group_id" {
  type = string
}
variable "location" {
  type = string
}
variable "common_tags" {
  type = map(string)
}
variable "vnet_name" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "aks_service_principal" {}