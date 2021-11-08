terraform {
  backend "s3" {
    bucket  = "lazztech-tfstate"
    key     = "redash/terraform.tfstate"
    encrypt = true
  }
}