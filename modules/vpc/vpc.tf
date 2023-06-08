# Create a VPC
resource "aws_vpc" "prodvpc" {
  cidr_block = "10.0.0.0/16"
}