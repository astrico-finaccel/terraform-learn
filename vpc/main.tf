resource "aws_vpc" "ast-test" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ast-test"
  }
}

resource "aws_subnet" "ast-public" {
  vpc_id                  = aws_vpc.ast-test.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "ast-public"
  }
}

resource "aws_subnet" "ast-public-2" {
  vpc_id                  = aws_vpc.ast-test.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "ast-public"
  }
}
resource "aws_subnet" "ast-private" {
  vpc_id     = aws_vpc.ast-test.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "ast-private"
  }
}

resource "aws_subnet" "ast-private-2" {
  vpc_id     = aws_vpc.ast-test.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "ast-private"
  }
}

resource "aws_internet_gateway" "ast-igw" {
  vpc_id = aws_vpc.ast-test.id

  tags = {
    Name = "ast-igw"
  }
}

resource "aws_eip" "ast-eip" {
  vpc = true
  tags = {
    Name = "ast-eip"
  }
}

resource "aws_nat_gateway" "ast-nat" {
  allocation_id = aws_eip.ast-eip.id
  subnet_id     = aws_subnet.ast-public.id

  tags = {
    Name = "ast-nat"
  }

  depends_on = [aws_internet_gateway.ast-igw, aws_eip.ast-eip]
}

resource "aws_route_table" "ast-rt-pub" {
  vpc_id = aws_vpc.ast-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ast-igw.id
  }
}

resource "aws_route_table" "ast-rt-priv" {
  vpc_id = aws_vpc.ast-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ast-nat.id
  }
}

resource "aws_route_table_association" "ast-pub-rta" {
  subnet_id      = aws_subnet.ast-public.id
  route_table_id = aws_route_table.ast-rt-pub.id
}

resource "aws_route_table_association" "ast-pub2-rta" {
  subnet_id      = aws_subnet.ast-public-2.id
  route_table_id = aws_route_table.ast-rt-pub.id
}

resource "aws_route_table_association" "ast-priv-rta" {
  subnet_id      = aws_subnet.ast-private.id
  route_table_id = aws_route_table.ast-rt-priv.id
}

resource "aws_route_table_association" "ast-priv2-rta" {
  subnet_id      = aws_subnet.ast-private-2.id
  route_table_id = aws_route_table.ast-rt-priv.id
}

resource "aws_security_group" "ast-allow-default" {
  name        = "ast-allow-default"
  description = "Allow TLS & SSH inbound traffic"
  vpc_id      = aws_vpc.ast-test.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ast-allow-default"
  }
}
