# Default Provider for AWS
provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

terraform {
  required_providers {
    aws = {
      version = "~> 4.0"
    }
  }
}
