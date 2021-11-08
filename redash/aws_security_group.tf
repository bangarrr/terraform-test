resource "aws_security_group" "redash" {
  name        = "redash"
  description = "For Redash"
  vpc_id      = aws_vpc.redash.id

  ingress {
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    security_groups = [aws_security_group.redash-lb.id]
  }

  lifecycle {
    ignore_changes = [ingress, egress]
  }

  tags = {
    Name = "redash"
  }

  depends_on = [
    aws_vpc.redash
  ]
}

resource "aws_security_group" "redash-lb" {
  name        = "redash-load-balancer"
  description = "sg for redash application load balancer"
  vpc_id      = aws_vpc.redash.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "redash-load-balancer"
  }

  depends_on = [
    aws_vpc.redash
  ]
}