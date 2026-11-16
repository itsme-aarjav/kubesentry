resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  dns_prefix = "${var.project_name}-${var.environment}"

  # Microsoft Entra Workload Identity integration:
  # Enables passwordless federation between Kubernetes ServiceAccounts and Azure Entra ID.
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  # AzureRM 5.x : explicit node provisioning profile
  node_provisioning_profile {
    mode = "Manual"
  }

  default_node_pool {
    name           = "system"
    node_count     = 1
    vm_size        = "Standard_D2ads_v7"
    vnet_subnet_id = azurerm_subnet.aks.id

    upgrade_settings {
      max_surge = "10%"
    }
  }

  # Managed Identity: AKS authenticates to Azure services (such as ACR)
  # without needing static service principal credentials or secrets.
  identity {
    type = "SystemAssigned"
  }

  # Managed Add-on: Azure Key Vault Secrets Store CSI Driver.
  # Allows pods to mount Key Vault secrets dynamically as volumes.
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.20.0.0/24"
    dns_service_ip = "10.20.0.10"
  }

  tags = {
    project = var.project_name
  }
}

# --------------------------------------------------------------------------
# Authorizes AKS Kubelet identity to pull images from ACR without
# requiring admin credentials or static secrets (AcrPull RBAC).
# --------------------------------------------------------------------------
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.main.id
  skip_service_principal_aad_check = true
}

