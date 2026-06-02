terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Keeps your code stable within major version 6
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}