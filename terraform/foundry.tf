# --------------------------------------------------------------------------
# Azure AI Foundry — underlying account infrastructure provisioned via Terraform.
# AI Project and Agent Service definitions are managed via the Foundry API/portal
# to support declarative Model Context Protocol (MCP) integrations.
# --------------------------------------------------------------------------

resource "azurerm_cognitive_account" "foundry" {
  name                = "aif-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "AIServices"
  sku_name            = "S0"

  # Zero static API keys: only Microsoft Entra ID (managed identity / RBAC)
  # authentication is permitted, adhering to the project-wide Zero-Trust model.
  local_auth_enabled = false

  # System-Assigned Managed Identity for the Foundry account
  identity {
    type = "SystemAssigned"
  }

  # Subdomain required for enabling the Azure AI Agent Service
  custom_subdomain_name      = "aif-${var.project_name}-${var.environment}"
  project_management_enabled = true

  tags = {
    project = var.project_name
  }
}

# --------------------------------------------------------------------------
# Model Deployment: provisioned with pay-as-you-go capacity.
# Note: Incident investigator runtime uses gpt-5-mini deployed via Foundry.
# --------------------------------------------------------------------------
resource "azurerm_cognitive_deployment" "agent_model" {
  name                 = "gpt-4.1-mini"
  cognitive_account_id = azurerm_cognitive_account.foundry.id

  model {
    format  = "OpenAI"
    name    = "gpt-4.1-mini"
    version = "2025-04-14"
  }

  sku {
    name     = "GlobalStandard"
    capacity = 30
  }

  lifecycle {
    ignore_changes = [model[0].version]
  }
}

output "foundry_endpoint" {
  value = azurerm_cognitive_account.foundry.endpoint
}


# --------------------------------------------------------------------------
# Grants Azure AI Developer role to the administrative CLI identity
# for portal management and integration verification.
# --------------------------------------------------------------------------
resource "azurerm_role_assignment" "current_user_ai_developer" {
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Azure AI Developer"
  scope                = azurerm_cognitive_account.foundry.id
}

# --------------------------------------------------------------------------
# Stores Foundry Endpoint URL in Key Vault as a centralized configuration item
# for automated discovery by CI pipelines and MCP tooling.
# --------------------------------------------------------------------------
resource "azurerm_key_vault_secret" "foundry_endpoint" {
  name         = "foundry-endpoint"
  value        = azurerm_cognitive_account.foundry.endpoint
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.current_user_keyvault_admin]
}
