

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.43.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }

  }
  required_version = "1.8.2"
}

provider "aws" {
  # Configuration options
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
  default_tags {
    tags = var.tags
  }
}

