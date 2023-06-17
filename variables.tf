variable "vpc_cidr" {
  description = "The CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}


variable "availability_zones" {
  description = "A list of availability zones for subnets"
  type        = list(string)
}


variable "public_subnets_cidrs" {
  description = "CIDRs for the Public Subnets"
  type        = list(string)
}


variable "private_subnets_cidrs" {
  description = "CIDRs for the Private Subnets"
  type        = list(string)
}

