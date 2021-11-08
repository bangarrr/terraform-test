resource "aws_subnet" "redash_public_a" {
  cidr_block              = "10.90.0.0/24"
  vpc_id                  = aws_vpc.redash.id
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "redash-public-a"
  }

  depends_on = [
    aws_vpc.redash
  ]
}

resource "aws_subnet" "redash_public_c" {
  cidr_block              = "10.90.1.0/24"
  vpc_id                  = aws_vpc.redash.id
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "redash-public-c"
  }

  depends_on = [
    aws_vpc.redash
  ]
}