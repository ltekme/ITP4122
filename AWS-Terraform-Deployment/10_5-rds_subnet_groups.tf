/*########################################################
RDS Subnet Groups

VTC_Service-MAIN_RDS-mysql:
    Ingress: 
        3306

########################################################*/
resource "aws_security_group" "VTC_Service-Main-mysql-aurora" {
  vpc_id = aws_vpc.VTC-Service.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-VTC_Service-MAIN_RDS-subnet_group"
  }
}


/*########################################################
Main RDS cluster Subnet Group

Subnets:
    Public Subnet in AZ A & B

########################################################*/
resource "aws_db_subnet_group" "VTC_Service-MAIN_RDS" {
  name       = lower("${var.project_name}-VTC_Service-MAIN_RDS-subnet_group")
  subnet_ids = [
    aws_subnet.VTC_Service-public-AZ_A.id,
    aws_subnet.VTC_Service-public-AZ_B.id,
    # aws_subnet.VTC_Service-private-AZ_A.id, 
    # aws_subnet.VTC_Service-private-AZ_B.id,
  ]

  tags = {
    Name = "${var.project_name}-VTC_Service-MAIN_RDS-subnet_group"
  }
}
 