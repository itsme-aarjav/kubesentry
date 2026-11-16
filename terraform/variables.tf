variable "project_name" {
  description = "Prefix used to name all resources"
  type        = string
  default     = "kubesentry"
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "francecentral"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "subnet_address_prefix" {
  description = "Address prefix for the AKS subnet"
  type        = list(string)
  default     = ["10.10.1.0/24"]
}
