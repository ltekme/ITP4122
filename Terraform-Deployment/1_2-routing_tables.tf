##########################################################
# Route Tables
##########################################################
resource "aws_route_table" "VTC_Service-public-Route_Table" {
  // public subnets
  vpc_id = aws_vpc.VTC-Service.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.VTC-Service.id
  }

  tags = {
    Name = "${aws_vpc.VTC-Service.tags.Name}-Public-RTB"
  }
}

resource "aws_route_table" "VTC_Service-private-AZ_A-Route_Table" {
  // private subnets in availability zone A
  vpc_id = aws_vpc.VTC-Service.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.VTC_Service-private-AZ_A.id
  }

  tags = {
    Name = "${aws_vpc.VTC-Service.tags.Name}-Private-RTB"
  }
}

resource "aws_route_table" "VTC_Service-private-AZ_B-Route_Table" {
  // private subnets in availability zone B
  vpc_id = aws_vpc.VTC-Service.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.VTC_Service-private-AZ_B.id
  }

  tags = {
    Name = "${aws_vpc.VTC-Service.tags.Name}-Private-RTB"
  }
}


##########################################################
# Public Route Tables Associations
##########################################################
resource "aws_route_table_association" "VTC_Service-public-AZ_A-RTB-Association" {
  // subnet in availability zone A
  subnet_id      = aws_subnet.VTC_Service-public-AZ_A.id
  route_table_id = aws_route_table.VTC_Service-public-Route_Table.id
}

resource "aws_route_table_association" "VTC_Service-public-AZ_B-RTB-Association" {
  // subnet in availability zone B
  subnet_id      = aws_subnet.VTC_Service-public-AZ_B.id
  route_table_id = aws_route_table.VTC_Service-public-Route_Table.id
}


##########################################################
# Private Route Tables Associations
##########################################################
resource "aws_route_table_association" "VTC_Service-private-AZ_A-RTB-Association" {
  // subnet in availability zone A
  subnet_id      = aws_subnet.VTC_Service-private-AZ_A.id
  route_table_id = aws_route_table.VTC_Service-private-AZ_A-Route_Table.id
}


resource "aws_route_table_association" "VTC_Service-private-AZ_B-RTB-Association" {
  // subnet in availability zone B
  subnet_id      = aws_subnet.VTC_Service-private-AZ_B.id
  route_table_id = aws_route_table.VTC_Service-private-AZ_B-Route_Table.id
}
