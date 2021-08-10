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
