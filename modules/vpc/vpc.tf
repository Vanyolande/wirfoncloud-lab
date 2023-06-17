#create vpc
resource "aws_vpc" "devvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "prodvpc"
    Project = "Yolanda Terraform Demo"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "devIGW" {
  vpc_id = aws_vpc.devvpc.id

  tags = {
    Name = "devIGW"
    Project = "Yolanda Terraform Demo"
  }
}


#Elastic IP
resource "aws_eip" "devNateGatewayEIP1" {

  tags  = {
  Name = "devNatGatewayEIP1"
  Project = "Yolanda Terraform Demo"
}
}


#Nat Gateway1
resource "aws_nat_gateway" "devNatGateway1"{
  allocation_id = aws_eip.devNateGatewayEIP1.id
  subnet_id     = aws_subnet.devPublicSubnet1.id

  tags = {
    Name = "devNatGateway1"
    Project = "Yolanda Terraform Demo"
  }
}



#Public Subnet 1
resource "aws_subnet" "devPublicSubnet1" {
  vpc_id     = aws_vpc.devvpc.id
  cidr_block = var.public_subnets_cidrs[0] 
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "devPublicSubnet1"
    Project = "Yolanda Terraform Project"
  }
}


#Public Subnet 2
resource "aws_subnet" "devPublicSubnet2" {
  vpc_id     = aws_vpc.devvpc.id
  cidr_block = var.public_subnets_cidrs[1] 
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "devPublicSubnet2"
    Project = "Yolanda Terraform Project"
  }
}

#Elatic IP 2
resource "aws_eip" "devNateGatewayEIP2" {

  tags  = {
  Name = "devNatGatewayEIP2"
  Project = "Yolanda Terraform Demo"
}
}


#Nat Gateway2
resource "aws_nat_gateway" "devNatGateway2"{
  allocation_id = aws_eip.devNateGatewayEIP2.id
  subnet_id     = aws_subnet.devPublicSubnet2.id

  tags = {
    Name = "devNatGateway2"
    Project = "Yolanda Terraform Demo"
  }
}


#Private subnet1
resource "aws_subnet" "devPrivateSubnet1" {
  vpc_id     = aws_vpc.devvpc.id
  cidr_block = var.private_subnets_cidrs[0] 
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "devPublicSubnet1"
    Project = "Yolanda Terraform Project"
  }
}


#Private subnet2
resource "aws_subnet" "devPrivateSubnet2" {
  vpc_id     = aws_vpc.devvpc.id
  cidr_block = var.private_subnets_cidrs[1] 
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "devPublicSubnet2"
    Project = "Yolanda Terraform Project"
  }
}


#public route tabe 
resource "aws_route_table" "devPublicRT" {
  vpc_id = aws_vpc.devvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devIGW.id
  }

  tags = {
    Name = "devPublicRT"
    Project = "Yolanda Terraform Demo"
  }
}


#private route table 1
resource "aws_route_table" "devPrivateRT1" {
  vpc_id = aws_vpc.devvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.devNatGateway1
  }

  tags = {
    Name = "devPrivateRT1"
    Project = "Yolanda Terraform Demo"
  }
}


#private route table 2
resource "aws_route_table" "devPrivateRT2" {
  vpc_id = aws_vpc.devvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.devNatGateway2
  }

  tags = {
    Name = "devPrivateRT2"
    Project = "Yolanda Terraform Demo"
  }
}
  



# route table association public subnet 1
resource "aws_route_table_association" "devPublicSubnet1" {
  subnet_id      = aws_subnet.devPublicSubnet1.id
  route_table_id = aws_route_table.devPublicRT.id
}


# route table association public subnet 2
resource "aws_route_table_association" "devPublicSubnet2" {
  subnet_id      = aws_subnet.devPublicSubnet2.id
  route_table_id = aws_route_table.devPublicRT.id
}


 #route table association private subnet 1
resource "aws_route_table_association" "devPrivateSubnet1" {
  subnet_id      = aws_subnet.devPrivateSubnet1.id
  route_table_id = aws_route_table.devPrivateRT1.id
}


# route table association private subnet 2
resource "aws_route_table_association" "devPrivateSubnet2" {
  subnet_id      = aws_subnet.devPrivateSubnet2.id
  route_table_id = aws_route_table.devPrivateRT2.id
}