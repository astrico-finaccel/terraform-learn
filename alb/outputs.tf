output "target_group_id" {
  value = aws_alb_target_group.default.id
}

output alb_name {
  value = aws_alb.alb.name
}

output alb_listener_arn {
  value = aws_alb_listener.http.arn
}
