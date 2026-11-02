variable "prefix" { type = string }
variable "region" { type = string }

resource "google_compute_network" "this" {
  name                    = "${var.prefix}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private" {
  name                     = "${var.prefix}-private"
  region                   = var.region
  network                  = google_compute_network.this.id
  ip_cidr_range            = "10.50.1.0/24"
  private_ip_google_access = true
}

output "network_id" { value = google_compute_network.this.id }
output "subnet_id" { value = google_compute_subnetwork.private.id }
