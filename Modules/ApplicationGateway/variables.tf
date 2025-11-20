variable "resource_group_name" {
  type = string
}
variable "appgw_uai_id" {
  type = list(string)
}
variable "vnet_name" {
  type = string
}
variable "location" {
  type = string
}
variable "appgw_subnet_id" {
  type = string
}
variable "appgw_public_ip" {
  type = string
}
variable "common_tags" {
  type = map(string)
}