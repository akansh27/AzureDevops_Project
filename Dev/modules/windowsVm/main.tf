data "azurerm_key_vault" "terrakv" {
  name                = "terrakvnew" // KeyVault name
  resource_group_name = "mykv" // resourceGroup
}

data "azurerm_key_vault_secret" "kvsecret" {
name = "secret" // Name of secret
key_vault_id = data.azurerm_key_vault.terrakv.id
}


resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    
    name                          = "internal"
    subnet_id                     = "${var.vnet_subnet_id}" //azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  count               = 1
  name                = "${var.vmName}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = data.azurerm_key_vault_secret.kvsecret.value //"P@$$w0rd1234!"
  network_interface_ids = [element(azurerm_network_interface.example.*.id, count.index)]
  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
