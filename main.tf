# Creates Network Interface and the reference link is https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

locals {
  ip_configuration = {
    private_ip_address_allocation = "Dynamic"
  }
}

# Get the subnet id using Resource Group Name and Virtual Network Name
data "azurerm_subnet" "subnet" {
  name                 = var.network_interface.subnet.name
  resource_group_name  = var.network_interface.subnet.resource_group_name
  virtual_network_name = var.network_interface.subnet.virtual_network_name
}

# Creates Network Interface
resource "azurerm_network_interface" "network_interface" {
  name                = var.network_interface.name
  resource_group_name = var.network_interface.resource_group_name
  location            = var.network_interface.location

  ip_configuration {
    name                          = var.network_interface.ip_configuration.name
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = local.ip_configuration.private_ip_address_allocation
  }

  tags = var.network_interface.tags

  lifecycle {
    ignore_changes = [ip_configuration["subnet_id"]]
  }
}