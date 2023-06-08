provider "aws" {
  region     = "us-east-1"
  profile = "default"
  }

  #create a vpc
  resource "aws_vpc" "prod" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "production-vpc"
  }
}

#create public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "production-public-subnet"
  }
}

#create EC2 instance
resource "aws_instance" "prod" {
  ami                     = "ami-007855ac798b5175e"
  instance_type           = "t2.micro"
  availability_zone = "us-east-1a"
  associate_public_ip_address = "true"
}

#create security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod.id

  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
      }

  tags = {
    Name = "production-SG"
  }
}

#create an internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = "gw"
  }
}

# create Route Table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  # resource "aws_route
  tags = {
    Name = "prod"
  }
}