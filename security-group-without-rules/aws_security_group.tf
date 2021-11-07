resource "aws_security_group" "without-rules" {
  name        = "without-rules"
  description = "test behavior without defining rules."
  vpc_id      = aws_vpc.sg-test.id

  tags = {
    Name = "without-rules"
  }

  depends_on = [
    aws_vpc.sg-test
  ]
}