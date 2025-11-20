### Application Gateway
resource "azurerm_application_gateway" "appgw" {
  name                = "applicationGateway"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  identity {
    type         = "UserAssigned"
    identity_ids = var.appgw_uai_id
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.appgw_subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }



  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = var.appgw_public_ip
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }



  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }



  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = "100"
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  ### ArgoCD Routing

  frontend_port {
    name = "argocdhttp"
    port = 8080
  }

  http_listener {
    name                           = "http8080Listener"
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = "argocdhttp"
    protocol                       = "Http"
  }

  backend_http_settings {
    name                  = "httpBackendArgoCD"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  request_routing_rule {
    name                       = "http8080RoutingRule"
    priority                   = "110"
    rule_type                  = "Basic"
    http_listener_name         = "http8080Listener"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "httpBackendArgoCD"
  }

  ###

  lifecycle {
    ignore_changes = [
      tags,
      backend_address_pool,
      backend_http_settings,
      http_listener,
      probe,
      request_routing_rule,
    ]
  }
}