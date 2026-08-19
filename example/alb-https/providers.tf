terraform {

  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 6.0"
    }
  }

}

provider "aws" {
  region = var.context.region
  profile = var.context.aws_profile
}
