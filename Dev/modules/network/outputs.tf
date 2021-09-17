
output "vnet_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = azurerm_subnet.example
}

