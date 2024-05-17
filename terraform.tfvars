virginia_cidr = "10.10.0.0/16"
# public_subnet = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"
subnets = ["10.10.0.0/24", "10.10.1.0/24"]
tags = {
  "env"     = "dev"
  "owner"   = "shiwa"
  "cloud "  = "aws"
  "IaC"     = "Terraform"
  "version" = "1.3.6"
  "project" = "cerberus"
  "region"  = "virginia"
}
sg_ingress_cidr   = "0.0.0.0/0"
enable_monitoring = false
ingress_port_list = [22, 443, 80]
