terraform {
  required_version = ">= 1.3.0"

  cloud {
    organization = "terraform-demo-state-migration"

    workspaces {
      name = "aws-vpc-state-migration-demo"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "demo_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "demo-vpc-state-migration"
    Environment = "demo"
    Project     = "terraform-state-migration"
  }
}

resource "aws_subnet" "test1" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "test1"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "leo-terraform-demo-bucket-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "demo-s3-state-migration"
    Environment = "demo"
    Project     = "terraform-state-migration"
  }
}

module "second_vpc" {
  source = "git::https://github.com/Leush91/SOD.git//terraform-aws-vpc-module?ref=main"

  vpc_cidr_block = "10.20.0.0/16"
  vpc_name       = "demo-second-vpc-from-git-module"
  environment    = "demo"
  project        = "terraform-state-migration"
}

output "second_vpc_id" {
  description = "ID-ul VPC-ului creat prin modulul din Git"
  value       = module.second_vpc.vpc_id
}

output "second_vpc_cidr_block" {
  description = "CIDR block-ul VPC-ului creat prin modulul din Git"
  value       = module.second_vpc.vpc_cidr_block
}