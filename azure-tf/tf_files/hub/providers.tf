terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.12"

  backend "azurerm" {
    resource_group_name  = "tf_backend"
    storage_account_name = "gosuretfbackend"
    container_name       = "hubtfstate"
    key                  = "hub-terraform.tfstate"
    subscription_id      = "45e11d13-6a36-4199-a853-61c0c5a00b6a"
  }
}

provider "azurerm" {
  features {}
}


provider "tls" {}

