terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.0"
    }
  }
  backend "s3" {
    bucket         = "kaif-devops-recipe-api"
    key            = "setup/setup.tfstate"
    region         = "us-east-1"
    dynamodb_table = "recipe-state-locking"
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project
      Contact     = var.contact
      Manageby    = "Terraform/setup"
    }
  }
}