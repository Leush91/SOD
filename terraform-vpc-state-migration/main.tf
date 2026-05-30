terraform {
  # Defines the minimum Terraform version required to run this configuration.
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      # Defines the AWS provider source from the Terraform Registry.
      source = "hashicorp/aws"

      # Uses version 6.x of the AWS provider, allowing compatible updates.
      version = "~> 6.0"
    }
  }
}

# Configures the AWS provider and sets the AWS region where resources will be created.
provider "aws" {
  region = var.aws_region
}

# Creates a new AWS VPC that will be used for the Terraform state migration demo.
resource "aws_vpc" "demo_vpc" {
  # Defines the IP address range for the VPC.
  cidr_block = "10.10.0.0/16"

  # Enables DNS resolution inside the VPC.
  enable_dns_support = true

  # Enables DNS hostnames for instances launched inside the VPC.
  enable_dns_hostnames = true

  tags = {
    # Human-readable name for the VPC.
    Name = "demo-vpc-state-migration"

    # Identifies this resource as part of a demo environment.
    Environment = "demo"

    # Identifies the project or purpose of this resource.
    Project = "terraform-state-migration"
  }
}