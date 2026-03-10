terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                   = "production-cluster"
  cluster_version                = "1.27"
  cluster_endpoint_public_access = true

  vpc_id     = "vpc-12345"
  subnet_ids = ["subnet-1", "subnet-2"]

  cluster_addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
  }

  tags = { Environment = "production" }
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.0.0"

  bucket = "my-production-bucket"
  acl    = "private"

  tags = { Environment = "production" }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.0"

  name = "production-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true

  tags = { Environment = "production" }
}
