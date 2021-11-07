resource "aws_s3_bucket" "tfstate" {
  bucket = "lazztech-tfstate"
  acl    = "private"
}