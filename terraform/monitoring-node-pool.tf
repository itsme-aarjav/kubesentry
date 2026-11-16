# --------------------------------------------------------------------------
# Dedicated node pool for observability (Prometheus/Grafana/Alertmanager).
# Isolated from the "system" pool that hosts the application, preventing
# the monitoring stack from starving app workloads of resources.
# --------------------------------------------------------------------------
resource "azurerm_kubernetes_cluster_node_pool" "monitoring" {
  name                  = "monitoring"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_D2ads_v7" # Aligned with system pool sizing
  node_count            = 1
  vnet_subnet_id        = azurerm_subnet.aks.id
  mode                  = "User" # User pool for workloads; system pool handles cluster infrastructure

  node_labels = {
    workload = "observability"
  }

  # Taint prevents standard application pods from scheduling on this node pool.
  # Only pods with matching tolerations (Prometheus/Grafana/Alertmanager) can schedule here.
  node_taints = [
    "workload=observability:NoSchedule"
  ]

  upgrade_settings {
    max_surge = "10%"
  }

  tags = {
    project = var.project_name
  }
}
