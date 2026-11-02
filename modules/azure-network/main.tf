variable "prefix" { type = string }
variable "location" { type = string }

resource "azurerm_resource_group" "this" {
  name     = "rg-${var.prefix}-network"
  location = var.location
  tags     = { ManagedBy = "Terraform", Project = "multicloud-demo" }
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.30.0.0/16"]
  tags                = { ManagedBy = "Terraform", Project = "multicloud-demo" }
}

resource "azurerm_subnet" "private" {
  name                 = "snet-private"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.30.1.0/24"]
}

output "network_id" { value = azurerm_virtual_network.this.id }
output "resource_group_name" { value = azurerm_resource_group.this.name }
