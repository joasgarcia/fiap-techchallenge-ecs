module "alb" {
  source = "../alb"

  aws_subnets = {
    subnet1 = var.aws_subnets.subnet1
    subnet2 = var.aws_subnets.subnet2
    subnet3 = var.aws_subnets.subnet3
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ecs_task_execution" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution.arn
}


resource "aws_ecs_cluster" "restaurant_cluster" {
  name = "restaurant-cluster"
}

resource "aws_ecs_task_definition" "restaurant_task" {
  family                   = "restaurant-task"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "restaurant-task",
      "image": "154843514058.dkr.ecr.us-east-1.amazonaws.com/restaurant-applatest:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "restaurant_service" {
  name            = "restaurant-service"
  cluster         = aws_ecs_cluster.restaurant_cluster.id
  task_definition = aws_ecs_task_definition.restaurant_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = module.alb.alb_target_group_arn
    container_name   = aws_ecs_task_definition.restaurant_task.family
    container_port   = 8080
  }

  network_configuration {
    subnets          = ["${var.aws_subnets.subnet1}", "${var.aws_subnets.subnet2}", "${var.aws_subnets.subnet3}"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.service_security_group.id}"]
  }
}

resource "aws_security_group" "service_security_group" {
  name        = "security-group-ecs-service"
  description = "Security Group ECS Restaurant Service"
  vpc_id            = data.aws_vpc.restaurant-vpc.id
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


