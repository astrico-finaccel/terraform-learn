variable "cluster" {
  type = string
}
variable "instance_group" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "image_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "desired_capacity" {
  type = number
}
variable "vpc_id" {
  type = string
}
variable "key_name" {
  type = string
}
variable "depends_id" {
  type = string
}
variable "iam_instance_profile_id" {
  type = string
}


variable "custom_userdata" {
  default     = ""
  description = "Inject extra command in the instance template to be run on boot"
}

variable "ecs_config" {
  default     = "echo '' > /etc/ecs/ecs.config"
  description = "Specify ecs configuration or get it from S3. Example: aws s3 cp s3://some-bucket/ecs.config /etc/ecs/ecs.config"
}

variable "ecs_logging" {
  default     = "[\"json-file\",\"awslogs\"]"
  description = "Adding logging option to ECS that the Docker containers can use. It is possible to add fluentd as well"
}

variable "cloudwatch_prefix" {
  default     = ""
  description = "If you want to avoid cloudwatch collision or you don't want to merge all logs to one log group specify a prefix"
}
