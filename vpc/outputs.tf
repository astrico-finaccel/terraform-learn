output "vpc_id" {
  value = aws_vpc.ast-test.id
}

output "public_subnet_id"{
  value = aws_subnet.ast-public.id
}

output "private_subnet_id" {
  value = aws_subnet.ast-private.id
}

output "security_group_id"{
  value = aws_security_group.ast-allow-default.id
}
