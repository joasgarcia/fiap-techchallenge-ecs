resource "aws_alb" "restaurant_alb" {
  name               = "${var.artifacts_prefix}-alb"
  load_balancer_type = "application"
  subnets = [
    "${var.aws_subnets.subnet1}",
    "${var.aws_subnets.subnet2}",
    "${var.aws_subnets.subnet3}"
  ]
  security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
}

resource "aws_security_group" "load_balancer_security_group" {
  name        = "${var.artifacts_prefix}-security_group_lb"
  description = "${var.artifacts_prefix} Security Group LB"
  vpc_id            = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.artifacts_prefix}-target-group"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.restaurant_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}