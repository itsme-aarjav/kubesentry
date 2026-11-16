data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                = "kv-${substr(replace(var.project_name, "-", ""), 0, 15)}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  # AzureRM 5.x
  rbac_authorization_enabled = true

  # Soft delete enabled for recovery
  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  tags = {
    project = var.project_name
  }
}

# --------------------------------------------------------------------------
# Authorizes CSI Secrets Store identity (provisioned by the
# key_vault_secrets_provider add-on in aks.tf) to READ secrets.
# Principle of least privilege: read-only access (Key Vault Secrets User).
# --------------------------------------------------------------------------
resource "azurerm_role_assignment" "aks_keyvault_secrets_user" {
  principal_id         = azurerm_kubernetes_cluster.main.key_vault_secrets_provider[0].secret_identity[0].object_id
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.main.id
}

# --------------------------------------------------------------------------
# Authorizes the active administrative CLI identity to manage secrets
# in Key Vault for administrative management and deployment tests.
# --------------------------------------------------------------------------
resource "azurerm_role_assignment" "current_user_keyvault_admin" {
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Key Vault Administrator"
  scope                = azurerm_key_vault.main.id
}

# --------------------------------------------------------------------------
# Application User-Assigned Managed Identity (UAMI) for Entra Workload Identity.
# Dedicated workload identity mounted by portfolio-app pods.
# --------------------------------------------------------------------------
resource "azurerm_user_assigned_identity" "portfolio_app" {
  name                = "id-${var.project_name}-app-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  tags = {
    project = var.project_name
  }
}

# --------------------------------------------------------------------------
# RBAC authorization: grants Key Vault Secrets User to the application UAMI.
# Read-only access (get/list) to required application secrets.
# --------------------------------------------------------------------------
resource "azurerm_role_assignment" "portfolio_app_keyvault_secrets_user" {
  principal_id         = azurerm_user_assigned_identity.portfolio_app.principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.main.id
}

# --------------------------------------------------------------------------
# Federated Identity Credential: establishes OIDC trust between the
# AKS OIDC issuer URL and the application UAMI for the specific
# Kubernetes ServiceAccount `portfolio-app-sa` in the `dev` namespace.
# --------------------------------------------------------------------------
resource "azurerm_federated_identity_credential" "portfolio_app" {
  name                      = "fic-${var.project_name}-app-${var.environment}"
  user_assigned_identity_id = azurerm_user_assigned_identity.portfolio_app.id
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = azurerm_kubernetes_cluster.main.oidc_issuer_url
  subject                   = "system:serviceaccount:dev:portfolio-app-sa"
}
