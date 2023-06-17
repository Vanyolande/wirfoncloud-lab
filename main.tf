terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


module "vpc-infra" {
  source                  = "./modules/vpc"

  # VPC Input Vars
  vpc_cidr                = local.vpc_cidr
  availability_zones      = local.availability_zones
  public_subnets_cidrs     = local.public_subnets_cidrs
  private_subnets_cidrs    = local.private_subnets_cidrs
}
