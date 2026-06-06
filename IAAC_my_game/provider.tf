terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Keeps your code stable within major version 6
    }
    tls = {
      source = "hashicorp/tls"
    }

    helm = {
      source = "hashicorp/helm"
      version = "3.2.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

data "aws_eks_cluster" "game_cluster" {
  name = aws_eks_cluster.game_cluster.name
}

data "aws_eks_cluster_auth" "game_cluster" {
  name = aws_eks_cluster.game_cluster.name
}