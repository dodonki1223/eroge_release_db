terraform {
  required_version = "1.1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.65.0"
    }
  }

  backend "s3" {
    region  = "ap-northeast-1"
    encrypt = true
    bucket  = "eroge-release-db"
    key     = "network/terraform.tfstate"
    profile = "terraform"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      Component   = var.component
      Application = var.application
    }
  }
}
