resource "aws_ecr_repository" "ast-ecr" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
output "image_repository_url" {
  value = aws_ecr_repository.ast-ecr.repository_url
}