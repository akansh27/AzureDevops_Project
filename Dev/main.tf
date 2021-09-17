provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East Us"
}

module "network" {
  source = "./modules/network"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = "subnet1"

}

module "windowsVm" {
    source = "./modules/windowsVm"
    //id = "${module.network.vnet_subnets.id[0]}"
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    vnet_subnet_id      = "${module.network.vnet_subnets.id}"

    
}


