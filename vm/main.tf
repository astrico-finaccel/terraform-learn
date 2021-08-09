provider "aws" {
  region  = "ap-southeast-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_network_interface" "ast-ni" {
  subnet_id   = var.subnet_id
  security_groups = var.security_group_id

  tags = {
    Name = "ast-ni"
  }
}

resource "aws_instance" "ast-vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = var.public_key

  network_interface {
    network_interface_id = aws_network_interface.ast-ni.id
    device_index         = 0
  }

  tags = {
    Name = "ast-vm"
  }
}

