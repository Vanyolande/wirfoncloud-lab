resource "aws_vpc" "devvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "prodvpc"
    Project = "Yolanda Terraform Demo"
  }
}


resource "aws_internet_gateway" "devIGW" {
  vpc_id = aws_vpc.devvpc

  tags = {
    Name = "devIGW"
    Project = "Yolanda Terraform Demo"
  }
}


resource "aws_eip" "devNateGatewayEIP1" {

  tags  = {
  Name = "devNatGatewayEIP1"
  Project = "Yolanda Terraform Demo"
}
}


resource "aws_nat_gateway" "devNatGateway1"{
  allocation_id = aws_eip.devNateGatewayEIP1.id
  subnet_id     = aws_subnet.devPublicSubnet1.id

  tags = {
    Name = "devNatGateway1"
    Project = "Yolanda Terraform Demo"
  }
}


resource "aws_subnet" "devPublicSubnet1" {
  vpc_id     = aws_vpc.devvpc.id
  cidr_block = var.public_subnets_cidrs[0] 
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "devPublicSubnet1"
    Project = "Yolanda Terraform Project"
  }
}


resource "aws_eip" "devNateGatewayEIP2" {

  tags  = {
  Name = "devNatGatewayEIP2"
  Project = "Yolanda Terraform Demo"
}
}


resource "aws_nat_gateway" "devNatGateway2"{
  allocation_id = aws_eip.devNateGatewayEIP2.id
  subnet_id     = aws_subnet.devPublicSubnet2.id

  tags = {
    Name = "devNatGateway2"
    Project = "Yolanda Terraform Demo"
  }
}


resource "aws_subnet" "devPrivateSubnet1" {
  vpc_id     = aws_vpc.devvpc.id
  cidr_block = var.private_subnets_cidrs[1] 
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "devPublicSubnet1"
    Project = "Yolanda Terraform Project"
  }
}


resource "aws_subnet" "devPrivateSubnet2" {
  vpc_id     = aws_vpc.devvpc.id
  cidr_block = var.private_subnets_cidrs[1] 
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "devPublicSubnet2"
    Project = "Yolanda Terraform Project"
  }
}


resource "aws_route_table" "devPublicRT" {
  vpc_id = aws_vpc.devvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devIGW.id
  }


  }

  tags = {
    Name = "devPublicRT"
    Project = "Yolanda Terraform Demo"
  }



resource "aws_route_table" "devPrivateRT" {
  vpc_id = aws_vpc.devvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.devNatGateway1
  }


  }

  Tags = {
    Name = "devPrivateRT"
    Project = "Yolanda Terraform Demo"
  }



