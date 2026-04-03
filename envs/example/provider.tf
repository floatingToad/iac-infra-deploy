###############################################################################
# Provider Configuration
#
# Set up your AWS credentials before running terraform init.
# Use one of the following methods:
#   1. Run: export AWS_ACCESS_KEY_ID="..." && export AWS_SECRET_ACCESS_KEY="..."
#   2. Run: aws configure
#   3. Edit ~/.aws/credentials directly
###############################################################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
