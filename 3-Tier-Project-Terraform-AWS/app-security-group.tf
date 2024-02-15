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



# Create Security Group - Web Traffic
resource "aws_security_group" "private_subnet" {
  name        = "vpc-web"
  description = "Dev VPC web"
  vpc_id = aws_vpc.main.id
  	# Took out the vpc_id row as we want this security group to be applied on default vpc  
  ingress {
    description      = "Allow Port 80 for http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # wherever is square bracket it’s a list and can input multiple list items.
  }
	# we can add one more rule here
ingress {
    description      = "Allow Port 443 for https"
    from_port        = 443
    to_port          = 443
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
    Name = "public-vpc-web-sg"
  }
}



output "public_vpc_ssh" {
  value = aws_security_group.public_subnet.id
}

output "public_instance_web_sg" {
  value = aws_security_group.private_subnet.id
}


# Security Group for ssh 
resource "aws_security_group" "ssh_securitygroup" {
  name = "SecurityGroup-ssh"
  description = "DummySecurityGroup"
  vpc_id = aws_vpc.main.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  tags = {
    "Name" = "DummySecurityGroup"
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

# DB - Security Group




# App - EC2 Instance Security Group
#resource "aws_security_group" "app_instance_sg" {
#db_security_groups = module.App_Tier.app_instance_sg