# Create Security Group - SSH
resource "aws_security_group" "public_subnet" {
  name        = "vpc-ssh"
  description = "Dev VPC SSH"
  vpc_id = aws_vpc.main.id
  	# Took out the vpc_id row as we want this security group to be applied on default vpc  
  ingress {
    description      = "Allow Port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # wherever is square bracket it’s a list and can input multiple list items.
  }

  	# Took out the vpc_id row as we want this security group to be applied on default vpc  
  ingress {
    description      = "Allow Port 80 for http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # wherever is square bracket it’s a list and can input multiple list items.
  }

  egress {
    description      = "Allow all ip and ports outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "public-vpc-ssh-sg"
  }
}


resource "aws_security_group" "private_subnet" {
  name        = "private-sg"
  description = "Private subnet security group "
  vpc_id = aws_vpc.main.id
  	# Took out the vpc_id row as we want this security group to be applied on default vpc  
  ingress {
    description      = "Allow Port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # wherever is square bracket it’s a list and can input multiple list items.
  }

  	# Took out the vpc_id row as we want this security group to be applied on default vpc  
  ingress {
    description      = "Allow Port 5000"
    from_port        = 5000
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # wherever is square bracket it’s a list and can input multiple list items.
  }

  egress {
    description      = "Allow all ip and ports outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "private-vpc-sg"
  }
}


# DB - Security Group
resource "aws_security_group" "db_security_group" {
  name = "mydb1"

  description = "RDS postgres server"
  vpc_id      = aws_vpc.main.id

  # Only postgres in
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ssh_securitygroup.id] #[var.db_security_groups]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0 
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
