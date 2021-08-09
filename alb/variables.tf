variable "alb_name" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "health_check_path" {
  type    = string
  default = "/healthcheck"
}