output "load_balancer_security_group" {
  value = aws_security_group.load_balancer_security_group.id
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}