locals {
  container_name = "${var.artifacts_prefix}-task"
}

module "alb" {
  source = "../alb"

  vpc_id = var.vpc_id
  artifacts_prefix = var.artifacts_prefix

  aws_subnets = {
    subnet1 = var.aws_subnets.subnet1
    subnet2 = var.aws_subnets.subnet2
    subnet3 = var.aws_subnets.subnet3
  }
}

#resource "aws_iam_role" "ecs_task_execution_role" {
#  name = "ecs-task-execution"
#
#  assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "ecs-tasks.amazonaws.com"
#      },
#      "Action": "sts:AssumeRole"
#    }
#  ]
#}
#EOF
#}
#
#resource "aws_iam_policy" "ecs_task_execution" {
#  policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Action": [
#        "ecr:GetAuthorizationToken",
#        "ecr:BatchCheckLayerAvailability",
#        "ecr:GetDownloadUrlForLayer",
#        "ecr:BatchGetImage",
#        "logs:CreateLogStream",
#        "logs:PutLogEvents"
#      ],
#      "Resource": "*"
#    }
#  ]
#}
#EOF
#}
#
#resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
#  role       = aws_iam_role.ecs_task_execution_role.name
#  policy_arn = aws_iam_policy.ecs_task_execution.arn
#}

resource "aws_cloudwatch_log_group" "restaurant_order_logs" {
  name              = "/ecs/${var.artifacts_prefix}-logs"
  retention_in_days = 7
}


resource "aws_ecs_cluster" "restaurant_cluster" {
  name = "${var.artifacts_prefix}-cluster"
}

resource "aws_ecs_task_definition" "restaurant_task" {
  family                   = "${var.artifacts_prefix}-task-family"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${local.container_name}",
      "image": "${var.aws_account_id}.dkr.ecr.${var.aws_account_region}.amazonaws.com/${var.ecr_repository_name}:latest",
      "essential": true,
      "environment": ${jsonencode(var.app_environments_vars)},
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.restaurant_order_logs.name}",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = var.ecs_task_execution_role_arn #aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "restaurant_service" {
  name            = "${var.artifacts_prefix}-ecs-service"
  cluster         = aws_ecs_cluster.restaurant_cluster.id
  task_definition = aws_ecs_task_definition.restaurant_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  health_check_grace_period_seconds = 300

  load_balancer {
    target_group_arn = module.alb.alb_target_group_arn
    container_name   = "${local.container_name}"
    container_port   = 8080
  }

  network_configuration {
    subnets          = ["${var.aws_subnets.subnet1}", "${var.aws_subnets.subnet2}", "${var.aws_subnets.subnet3}"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.service_security_group.id}"]
  }
}

resource "aws_security_group" "service_security_group" {
  name        = "${var.artifacts_prefix}-security-group-ecs-service"
  description = "Security Group ECS ${var.artifacts_prefix} Service"
  vpc_id            = var.vpc_id
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${module.alb.load_balancer_security_group}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


