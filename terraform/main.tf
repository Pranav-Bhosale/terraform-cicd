provider "aws" {
  region  = "us-east-1"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.16"
    }
  }
  backend "s3" {
    bucket = "pb-terraformt-bucket"
    key    = "create-instance/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
  required_version = ">= 1.2.0"
}

module "infra" {
  source = "./create-instance"
}
module "backend-config" {
  source = "./create-s3-bucket"
}