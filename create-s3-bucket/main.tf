terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}
provider "aws" {
  region  = "us-east-1"
}

resource "aws_s3_bucket" "pb-terraform-bucket" {
  bucket = "pb-terraformt-bucket"
  force_destroy = true
  tags = {
    Name        = "pb-terraform-bucket"
  }
}