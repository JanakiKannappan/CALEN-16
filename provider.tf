terraform {
  required_providers {
    aws = {
      source  = "aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket                  = "terraform-s3-buc01"
    key                     = "terraform.tfstate"
    region                  = "us-east-1"
  }
}