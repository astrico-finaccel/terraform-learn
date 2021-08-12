variable "service_name" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "desired_count" {
  type = number
}

# variable "iam_role_id" {
#   type = string
# }

# variable "target_group_arn" {
#   type = string
# }

variable "container_name" {
  type = string
}
variable "container_port" {
  type = number
}

# variable "container_definitions" {
#   type = string
# }

variable "task_definition" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "health_check_path" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "alb_listener_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}
