# Remote state stored in Azure Blob Storage rather than local disk:
# - State persists independently of the local machine
# - State blob locking prevents concurrent apply executions
# - Required architecture for automated CI/CD and team operations
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-kubesentry-tfstate"
    storage_account_name = "sttfkubesentrydev"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
