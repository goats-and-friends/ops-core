terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.70"
    }
  }

  backend "s3" {
    key = "environments/shared/core.tf"
  }

  required_version = "~> 1.0"
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      env = "production"
    }
  }
}

resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}
