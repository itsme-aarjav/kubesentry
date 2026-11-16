output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.main.name
}

output "vnet_name" {
  description = "Name of the created virtual network"
  value       = azurerm_virtual_network.main.name
}

output "aks_subnet_id" {
  description = "Subnet ID allocated for AKS"
  value       = azurerm_subnet.aks.id
}

output "acr_login_server" {
  description = "ACR login server URL (used in GitLab CI pipeline for push/pull)"
  value       = azurerm_container_registry.main.login_server
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster (used with `az aks get-credentials`)"
  value       = azurerm_kubernetes_cluster.main.name
}

output "key_vault_name" {
  description = "Name of the Key Vault (referenced in Kubernetes SecretProviderClass)"
  value       = azurerm_key_vault.main.name
}

output "portfolio_app_identity_client_id" {
  description = "Client ID of the application UAMI — referenced in serviceaccount.yaml and secret-provider-class.yaml"
  value       = azurerm_user_assigned_identity.portfolio_app.client_id
}
