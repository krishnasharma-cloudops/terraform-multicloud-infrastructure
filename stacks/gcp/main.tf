terraform {
  required_version = ">= 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
}
variable "project_id" {
  type = string
}
variable "region" {
  type    = string
  default = "asia-south1"
}
variable "prefix" {
  type    = string
  default = "ksmulti"
}
module "network" {
  source = "../../modules/gcp-network"
  prefix = var.prefix
  region = var.region
}
output "network_id" {
  value = module.network.network_id
}
