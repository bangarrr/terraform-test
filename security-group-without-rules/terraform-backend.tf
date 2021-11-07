terraform {
  backend "s3" {
    bucket  = "lazztech-tfstate"
    key     = "security-group-without-rules/terraform.tfstate"
    encrypt = true
  }
}