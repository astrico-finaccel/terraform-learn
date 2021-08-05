provider "aws" {
  region  = "ap-southeast-1"
}

module "vpc" {
  source = "./vpc"
}

resource aws_key_pair "ast-pkey" {
  key_name = "ast-pkey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDiHq4vfgd0QAC/UNzvezU204gWAWQgloaAsP7S0qA2kEnknnsfWwmUCwwlVb4fNcY/cXmt5jStjMW1yDtcQGDDb/n4K88L83pUvUC7BYE55ADquvCFoamVHmAT63Ko5rvjol0kYZ8cEP6QpHAzwqqOyj/YMB+ZD+Uq3YoU16ODiJSvY1mGchal2iB1SFgMyRfleiPtNnX1zVYKUe0qLQFYtss6G51gT/vaQd4B7jrXOHXeowvGCI0DLgHGjJmeLlzia+MlqYKcrRJ/GYUy1Meyc5UNU9kBVUgKhIhYQYxKvkQw+AnrTS5sVgbTPGP3FeS1AzqQoUl+PDylDz5UfnCOmpndn7AhX3hgsARfb/mW4dXTDda9XHdKd9Vx7L/bnzPE3n5ZFdcyc4RpJf1aAmvoQI7h31IUIxEr35l5MA/fj65E35RI62dd0TPh5AdNf2pnPMviO3KM0P0vO1Xpbz5vyJHUfroXpexdmYyLpca989Ym52HAmbNukkzNlElsGg8= astrico@astricos-MacBook-Pro.local"
}

module "vm" {
  source = "./vm"

  subnet_id = module.vpc.public_subnet_id
  security_group_id = [ module.vpc.security_group_id ]
  public_key = aws_key_pair.ast-pkey.key_name
}

module "vm_2" {
  source = "./vm"

  subnet_id = module.vpc.private_subnet_id
  security_group_id = [ module.vpc.security_group_id ]
  public_key = aws_key_pair.ast-pkey.key_name

}