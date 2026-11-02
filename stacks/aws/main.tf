terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.region
}
variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "prefix" {
  type    = string
  default = "ksmulti"
}
module "network" {
  source = "../../modules/aws-network"
  prefix = var.prefix
}
output "network_id" {
  value = module.network.network_id
}
