resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition
  desired_count   = var.desired_count

  load_balancer {
    target_group_arn = aws_alb_target_group.service_target.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }
}

resource "aws_alb_target_group" "service_target" {
  name                 = "${var.alb_name}-${var.service_name}"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 60

  health_check {
    path     = var.health_check_path
    protocol = "HTTP"
  }
}

resource "aws_alb_listener_rule" "forward_rule" {
  listener_arn = var.alb_listener_arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.service_target.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
