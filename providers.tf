terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "lab"
  shared_credentials_files = ["$HOME/.aws/credentials"]

  default_tags {
    tags = {
      Name = "restaurant-app-infrastructure"
    }
  }
}