# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
resource "aws_instance" "public-ec2vm" {
  # instance_count         = 1
  # count                  = "${var.instance_count}"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro" #var.instance_type
  user_data = file("${path.module}/frontend-app-install.sh")  
  key_name               = "terraform-key" #var.instance_keypair
  # monitoring             = true
  subnet_id              = aws_subnet.public_subnets[0].id #module.vpc.public_subnets[0] #We have 2 public subnets, index [0] & [1]
  security_groups = [aws_security_group.public_subnet.id] #[module.public_bastion_sg.security_group_id] 
 # associate_public_ip_address = "true"
  #tags = local.common_tags
  tags = {
    "Name" = "Public-ec2"
  }
}



# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets
resource "aws_instance" "private-ec2vm" {
  depends_on = [aws_vpc.main] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
#  source  = "terraform-aws-modules/ec2-instance/aws"
#  version = "3.3.0"
  # insert the 10 required variables here
#  name                   = "Private-ec2"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro" #var.instance_type
  user_data = file("${path.module}/backend-app-install.sh")
  key_name               = "terraform-key" #var.instance_keypair
  #monitoring             = true
  security_groups        = [aws_security_group.public_subnet.id] #[module.private_sg.security_group_id]
  subnet_id              = aws_subnet.private_subnets[0].id # module.vpc.public_subnets[0]  
  # subnet_ids = [
  #   module.vpc.private_subnets[0],
  #   module.vpc.private_subnets[1]
  # ]  
  #instance_count         = var.private_instance_count
  #user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "Private-ec2"
  }
}
