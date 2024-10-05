resource "azurerm_kubernetes_cluster_addon_profile" "agic" {
  kubernetes_cluster_id = var.kubernetes_cluster_id

  #ingress_application_gateway {
  #  enabled = true
  #  gateway_id = var.gateway_id
  #  subnet_cidr = var.subnet_cidr
  #}
}

output "agic_enabled" {
  value = azurerm_kubernetes_cluster_addon_profile.agic.ingress_application_gateway.enabled
}
