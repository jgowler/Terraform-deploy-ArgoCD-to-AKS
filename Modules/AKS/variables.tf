variable "resource_group_name" {
  description = "Resource Group in subscription"
  type        = string
}
variable "clustername" {
  description = "AKS cluster name"
  type        = string
}
variable "location" {
  type = string
}
variable "ssh_public_key" {
  type = string
}
variable "common_tags" {
  type = map(string)
}
variable "appgw_id" {
  type = string
}
variable "appgw_name" {
  type = string
}