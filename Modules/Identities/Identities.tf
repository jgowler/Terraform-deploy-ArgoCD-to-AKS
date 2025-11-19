### Role Assignments:
locals {
  role_assignment_list = flatten([
    for principal_id in var.principal_ids : [
      for role, scopes in var.role_assignments : [
        for scope in scopes : {
          principal_id = principal_id
          role         = role
          scope        = scope
        }
      ]
    ]
  ])

  role_assignment_map = {
    for ra in local.role_assignment_list :
    "${ra.principal_id}-${ra.role}-${basename(ra.scope)}" => ra
  }
}

resource "azurerm_role_assignment" "assign_roles" {
  for_each = local.role_assignment_map

  principal_id         = each.value.principal_id
  role_definition_name = each.value.role
  scope                = each.value.scope
}
