/*########################################################
RDS Subnet Groups

VTC_Service-MAIN_RDS-mysql:
    Ingress: 
        3306

########################################################*/
resource "aws_security_group" "VTC_Service-MAIN_RDS-mysql" {
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
 