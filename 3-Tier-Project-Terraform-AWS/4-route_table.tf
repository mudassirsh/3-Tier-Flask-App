# Internet Gateway
resource "aws_internet_gateway" "gw" {
  depends_on = [
    aws_vpc.main,
    aws_subnet.public_subnets,
    aws_subnet.private_subnets
  ]
 
 vpc_id = aws_vpc.main.id
 
 tags = {
   Name = "Internet-Gateway"
 }
}


# Public Route Table 
resource "aws_route_table" "public_route_table" {
    depends_on = [
    aws_vpc.main,
    aws_internet_gateway.gw
  ]
    
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id # attached gw to route table
  }


  tags = {
    Name = "public-route-table"
  }
}



# Public Route Table Association
resource "aws_route_table_association" "public_subnet_asso" {
    depends_on = [
    aws_vpc.main,
    aws_subnet.public_subnets,
    aws_subnet.private_subnets,
    aws_route_table.public_route_table
  ]
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.public_route_table.id
}



# Private Route Table
resource "aws_route_table" "private_route_table" {  
    depends_on = [
    aws_nat_gateway.nat_gateway
  ]
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

    tags = {
    Name = "private-route-table"
  }
}


# Private route table association
resource "aws_route_table_association" "private_subnet_asso" {
    depends_on = [
    aws_route_table.private_route_table
  ]
  subnet_id = aws_subnet.private_subnets[0].id
  route_table_id = aws_route_table.private_route_table.id
}
