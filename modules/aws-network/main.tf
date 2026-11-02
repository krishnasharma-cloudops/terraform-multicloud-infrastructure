variable "prefix" { type = string }

resource "aws_vpc" "this" {
  cidr_block           = "10.40.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.prefix}-vpc", ManagedBy = "Terraform", Project = "multicloud-demo" }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.40.1.0/24"
  map_public_ip_on_launch = false
  tags = { Name = "${var.prefix}-private", ManagedBy = "Terraform" }
}

output "network_id" { value = aws_vpc.this.id }
output "subnet_id" { value = aws_subnet.private.id }
