output "node_pool_id" {
  description = "The ID of the created AKS node pool"
  value       = azurerm_kubernetes_cluster_node_pool.aks_user_node_pool.id
}