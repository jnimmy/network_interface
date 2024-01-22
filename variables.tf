variable "network_interface" {

  description = "Reference - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface"

  type = object({
    name                = string
    resource_group_name = string
    location            = string

    subnet = object({
      name                 = string
      resource_group_name  = string
      virtual_network_name = string
    })

    ip_configuration = object({
      name                = string
      resource_group_name = string
    })

    tags = map(any)
  })
}