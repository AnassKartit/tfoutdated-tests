terraform {
  source = "tfr:///Azure/avm-res-network-virtualnetwork/azurerm?version=0.7.0"
}

inputs = {
  name                = "vnet-production"
  resource_group_name = "rg-production"
  location            = "West Europe"
  address_space       = ["10.0.0.0/16"]

  subnets = {
    default = {
      name             = "default"
      address_prefixes = ["10.0.1.0/24"]
    }
  }

  tags = { Environment = "production" }
}
