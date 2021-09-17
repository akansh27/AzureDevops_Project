resource "azurerm_virtual_network" "example" {
  name                = "${var.vnet}"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  
}

resource "azurerm_subnet" "example" {

  name                 = "${var.subnet_names}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = "${var.subnet_prefixes}"
}


