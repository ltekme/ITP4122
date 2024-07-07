/*########################################################
Main VPC Block

CIDR: 10.0.0.0/16

########################################################*/
resource "aws_vpc" "VTC-Service" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-Service-VPC"
  }
}


/*########################################################
VPC Internet Gateway

########################################################*/
resource "aws_internet_gateway" "VTC-Service" {
  vpc_id = aws_vpc.VTC-Service.id

  tags = {
    Name = "${aws_vpc.VTC-Service.tags.Name}-IGW"
  }
}


/*########################################################
Elastic IP for NAT Gateway

########################################################*/
resource "aws_eip" "VTC-Service-EIP-NAT-AZ_A" {
  // Avalability Zone A - NAT Gateway
  domain = "vpc"

  depends_on = [
    aws_internet_gateway.VTC-Service
  ]

  tags = {
    Name = "${aws_vpc.VTC-Service.tags.Name}-EIP-NATGW-AZ_A"
  }
}

resource "aws_eip" "VTC-Service-EIP-NAT-AZ_B" {
  // Avalability Zone B - NAT Gateway
  domain = "vpc"

  depends_on = [
    aws_internet_gateway.VTC-Service
  ]

  tags = {
    Name = "${aws_vpc.VTC-Service.tags.Name}-EIP-NATGW-AZ_B"
  }
}


/*########################################################
VPC NAT Gateway For Private Subnets

########################################################*/
resource "aws_nat_gateway" "VTC_Service-private-AZ_A" {
  // Avalability Zone A - NAT Gateway
  subnet_id     = aws_subnet.VTC_Service-public-AZ_A.id
  allocation_id = aws_eip.VTC-Service-EIP-NAT-AZ_A.id

  depends_on = [
    aws_internet_gateway.VTC-Service
  ]

  tags = {
    Name = "${aws_vpc.VTC-Service.tags.Name}-NAT_GW-AZ_A"
  }
}

resource "aws_nat_gateway" "VTC_Service-private-AZ_B" {
  // Avalability Zone B - NAT Gateway
  subnet_id     = aws_subnet.VTC_Service-public-AZ_B.id
  allocation_id = aws_eip.VTC-Service-EIP-NAT-AZ_B.id

  depends_on = [
    aws_internet_gateway.VTC-Service
  ]
  tags = {
    Name = "${aws_vpc.VTC-Service.tags.Name}-NAT_GW-AZ_B"
  }
}
