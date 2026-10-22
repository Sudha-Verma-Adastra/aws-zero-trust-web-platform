terraform {
  required_version = ">= 1.6.0"

  cloud {
    organization = "sudha-adastra"

    workspaces {
      name = "aws-zero-trust-web-platform-dev"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 7.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "aws-zero-trust-web-platform"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}
