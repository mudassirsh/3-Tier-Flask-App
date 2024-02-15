/*

1. created VPC
2. Created public and private subnets
3. Created Public and Private route tables
4. Created Internet Gateway and assigned to Pub RT
5. Created NAT Gateway and assigned to Priv RT


*/

# Region
variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "Main VPC CIDR Block"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.2.0/24"]
}


variable "database_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.3.0/24", "10.0.4.0/24"]
}


#In order to create subnets in different AZs
variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a",  "us-east-1b"]
}




# db_rds_instance_name                    = "dbpostgres"

/*
variable "az_public_subnet" {
  type = map(string)
}

variable "az_private_subnet" {
  type = map(string)
}

variable "az_database_subnet" {
  type = map(string)
}

variable "availability_zones" {
  type = list(string)
}

*/