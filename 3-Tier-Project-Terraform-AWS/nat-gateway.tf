#---------- Nat Gateway

# Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "bastion_eip" {
  depends_on = [aws_instance.public-ec2vm]
  #instance = aws_instance.public-ec2vm.id        #module.ec2_public.id[0] 
  domain = "vpc"
  tags = {
    "Name" = "bastion_eip"
  }
}

#instance = "${aws_instance.myinstance.*.id[count.index]}"

# Creating a NAT Gateway!
resource "aws_nat_gateway" "nat_gateway" {
  depends_on = [
    aws_eip.bastion_eip, aws_instance.public-ec2vm
  ]
  allocation_id = aws_eip.bastion_eip.id
  subnet_id = aws_subnet.public_subnets[0].id           #--nat_gateway.id
  tags = {
    "Name" = "NatGateway"
  }
}



output "nat_gateway_ip" {
  value = aws_eip.bastion_eip.public_ip
}
