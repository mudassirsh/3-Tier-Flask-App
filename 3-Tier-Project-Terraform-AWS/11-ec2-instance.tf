# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
resource "aws_instance" "public-ec2vm" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro" #var.instance_type
  user_data = file("${path.module}/frontend-app-install.sh")  
  key_name               = "terraform-key" #var.instance_keypair
  # monitoring             = true
  subnet_id              = aws_subnet.public_subnets[0].id 
  security_groups = [aws_security_group.public_subnet.id] 
 # associate_public_ip_address = "true"
  tags = {
    "Name" = "Public-ec2"
  }
}



# EC2 Instances that will be created in VPC Private Subnets
resource "aws_instance" "private-ec2vm" {
  depends_on = [aws_vpc.main] 
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro" #var.instance_type
  user_data = file("${path.module}/backend-app-install.sh")
  key_name               = "terraform-key" #var.instance_keypair
  #monitoring             = true
  security_groups        = [aws_security_group.public_subnet.id]
  subnet_id              = aws_subnet.private_subnets[0].id 
  tags = {
    "Name" = "Private-ec2"
  }
}
