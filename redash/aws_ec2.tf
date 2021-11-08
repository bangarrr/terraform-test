resource "aws_instance" "redash" {
  ami           = "ami-060741a96307668be"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.redash_public_a.id
  ebs_optimized = true
  vpc_security_group_ids = [
    aws_security_group.redash.id
  ]
  monitoring = false
  key_name   = "redash"

  root_block_device {
    delete_on_termination = false
    volume_size           = 8
  }

  tags = {
    Name = "redash"
  }

  depends_on = [
    aws_subnet.redash_public_a,
    aws_security_group.redash
  ]
}