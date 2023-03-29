resource "aws_s3_bucket" "pb-terraform-bucket" {
  bucket = "pb-terraformt-bucket"
  force_destroy = true
  tags = {
    Name        = "pb-terraform-bucket"
  }
}