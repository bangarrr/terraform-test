resource "aws_lb" "redash" {
  name                       = "redash"
  internal                   = false
  enable_deletion_protection = true
  load_balancer_type         = "application"
  security_groups = [
    aws_security_group.redash-lb.id
  ]

  subnets = [
    aws_subnet.redash_public_a.id,
    aws_subnet.redash_public_c.id
  ]

  depends_on = [
    aws_security_group.redash-lb,
    aws_subnet.redash_public_a,
    aws_subnet.redash_public_c
  ]
}

resource "aws_lb_listener" "redash_http" {
  load_balancer_arn = aws_lb.redash.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.redash.arn
    type             = "forward"
  }

  depends_on = [
    aws_lb.redash,
    aws_lb_target_group.redash
  ]
}

resource "aws_lb_target_group" "redash" {
  name                 = "redash-instance"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = aws_vpc.redash.id
  deregistration_delay = 0

  health_check {
    path                = "/login"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = 15
    healthy_threshold   = 2
    unhealthy_threshold = 10
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_vpc.redash]
}

resource "aws_lb_target_group_attachment" "redash" {
  target_group_arn = aws_lb_target_group.redash.arn
  target_id        = aws_instance.redash.id
  port             = 80

  depends_on = [
    aws_instance.redash,
    aws_lb_target_group.redash
  ]
}