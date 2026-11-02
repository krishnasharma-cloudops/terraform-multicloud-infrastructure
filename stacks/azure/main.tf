terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
variable "subscription_id" {
  type = string
}
variable "location" {
  type    = string
  default = "centralindia"
}
variable "prefix" {
  type    = string
  default = "ksmulti"
}
module "network" {
  source   = "../../modules/azure-network"
  prefix   = var.prefix
  location = var.location
}
output "network_id" {
  value = module.network.network_id
}
