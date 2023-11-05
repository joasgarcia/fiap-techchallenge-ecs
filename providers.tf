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
  access_key = "<SEU ACCESS KEY>"
  secret_key = "<SEU SECRET KEY>"

  default_tags {
    tags = {
      Name = "restaurant-app-infrastructure"
    }
  }
}