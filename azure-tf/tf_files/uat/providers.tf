terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      #version = "~> 3.0"
      version = ">= 3.0.0"
    }
  }

  required_version = ">= 0.12"

  backend "azurerm" {
    resource_group_name  = "tf_backend"
    storage_account_name = "gosuretfbackend"
    container_name       = "uattfstate"
    key                  = "uat-terraform.tfstate"
    subscription_id      = "45e11d13-6a36-4199-a853-61c0c5a00b6a"
  }

  #backend "azurerm" {
  #  resource_group_name  = "gosure-uat"
  #  storage_account_name = "gosurebackenduat"
  #  container_name       = "myblobcontainer"
  #  key                  = "uat-terraform.tfstate"
  #  #use_msi              = true
  #  #subscription_id      = "7172ed41-24a4-440c-b608-770459b41f18"
  #}
}

provider "azurerm" {
  features {}
  #use_msi = false  # Use managed identity
  #subscription_id      = "7172ed41-24a4-440c-b608-770459b41f18"
}

# Import user-assigned managed identity
#data "azurerm_user_assigned_identity" "uami" {
#  name                = var.uami_name
#  resource_group_name = var.uami_rg_name
#}

provider "tls" {}

