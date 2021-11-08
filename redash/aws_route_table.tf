resource "aws_internet_gateway" "redash" {
  vpc_id = aws_vpc.redash.id

  tags = {
    Name = "redash"
  }

  depends_on = [
    aws_vpc.redash
  ]
}

resource "aws_route_table" "redash_public" {
  vpc_id = aws_vpc.redash.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.redash.id
  }

  tags = {
    Name = "redash-public"
  }

  depends_on = [
    aws_vpc.redash,
    aws_internet_gateway.redash
  ]
}

resource "aws_route_table_association" "redash_public_a" {
  route_table_id = aws_route_table.redash_public.id
  subnet_id      = aws_subnet.redash_public_a.id

  depends_on = [
    aws_route_table.redash_public,
    aws_subnet.redash_public_a
  ]
}