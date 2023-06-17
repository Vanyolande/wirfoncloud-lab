output "dev_vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.devvpc.id
}

output "dev_public_subnets" {
  description = "Will be used by Web Server Module to set subnet_ids"
  value  = [aws_subnet.devPublicSubnet1.id, aws_subnet.devPublicSubnet2.id]
}

output "dev_private_subnets" {
  description = "Will be used by RDS Module to set subnet_ids"
  value = [aws_subnet.devPrivateSubnet1.id, aws_subnet.devPrivateSubnet2.id]
}



