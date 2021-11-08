resource "aws_vpc" "redash" {
  cidr_block           = "10.90.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "redash"
  }
}