# VPC Resource
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  #cidr_block = "10.0.0.0/16"

  tags = {
    Name = "3Tier-vpc"
  }
}



resource "aws_subnet" "public_subnets" {
  depends_on = [
    aws_vpc.main
  ]
 count             = length(var.public_subnet_cidrs)
 vpc_id            = aws_vpc.main.id
 cidr_block        = element(var.public_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 map_public_ip_on_launch = true
 
 tags = {
   Name = "Public-Subnet ${count.index + 1}"
 }
}



resource "aws_subnet" "private_subnets" {
  depends_on = [
    aws_vpc.main
  ]
 count             = length(var.private_subnet_cidrs)
 vpc_id            = aws_vpc.main.id
 cidr_block        = element(var.private_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 
 tags = {
   Name = "Private-Subnet ${count.index + 1}"
 }
}


# Database Subnet
resource "aws_subnet" "database_subnet" {
  depends_on = [
    aws_vpc.main,
    aws_subnet.public_subnets,
    aws_subnet.private_subnets
  ]
  count = length(var.database_subnet_cidrs)
  
  vpc_id = aws_vpc.main.id

  cidr_block        = element(var.database_subnet_cidrs, count.index) #each.key
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "database-subnet-${count.index + 1}"
  }
}



/*
======================================
       OUTPUTS
======================================    
*/


output "vpc_id" {
  value = aws_vpc.main.id
}


output "public_subnet_id" {
  value = toset([for subnet in aws_subnet.public_subnets : subnet.id])
}


output "private_subnet_id" {
  value = toset([for subnet in aws_subnet.private_subnets : subnet.id])
}


