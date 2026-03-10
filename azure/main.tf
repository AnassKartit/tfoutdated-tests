terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-production"
  location = "West Europe"
}

module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.7.0"

  name                = "vnet-production"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]

  subnets = {
    default = {
      name             = "default"
      address_prefixes = ["10.0.1.0/24"]
    }
  }

  tags = { Environment = "production" }
}

module "acr" {
  source  = "Azure/avm-res-containerregistry-registry/azurerm"
  version = "0.4.0"

  name                = "acrproduction"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Premium"

  tags = { Environment = "production" }
}

module "keyvault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.5.0"

  name                = "kv-production"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = "00000000-0000-0000-0000-000000000000"

  tags = { Environment = "production" }
}
