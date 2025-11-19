variable "principal_ids" {
  type = list(string)
  description = "List of principal ID's from other modules"
}
variable "role_assignments" {
  type = map(list(string))
  description = "List of permissions to be granted"
}