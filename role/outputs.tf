output "ecs_instance_role_id" {
  value = aws_iam_instance_profile.ecs.id
}
output "ecs_elb_role_id" {
  value = aws_iam_role.ecs_lb_role.id
}

