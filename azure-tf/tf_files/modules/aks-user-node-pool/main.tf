resource "azurerm_kubernetes_cluster_node_pool" "aks_user_node_pool" {
  name                = var.node_pool_name
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks.id
  vm_size             = var.vm_size
  #node_count          = var.node_count
  max_pods            = var.max_pods
  os_disk_size_gb     = var.os_disk_size_gb
  mode                = "User"

  # Autoscaling configuration
  enable_auto_scaling   = var.enable_auto_scaling
  min_count             = var.min_count
  max_count             = var.max_count

}

data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  resource_group_name = var.resource_group
}
