resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = "appGwIpConfig"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontendIp"
    public_ip_address_id = var.public_ip_id
  }

  backend_address_pool {
    name = "defaultBackendPool"
  }

  backend_http_settings {
    name                  = "defaultHttpSettings"
    cookie_based_affinity  = "Disabled"
    path                   = "/"
    port                   = 80
    protocol               = "Http"
    request_timeout        = 20
  }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "frontendIp"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "defaultRoutingRule"
    rule_type                  = "Basic"
    http_listener_name          = "httpListener"
    backend_address_pool_name   = "defaultBackendPool"
    backend_http_settings_name  = "defaultHttpSettings"
    priority                    = 1
  }
  
  waf_configuration {
    enabled            = var.waf_enabled
    firewall_mode      = var.firewall_mode
    rule_set_type      = var.rule_set_type
    rule_set_version   = var.rule_set_version
  }

  tags = var.tags 

  
}
