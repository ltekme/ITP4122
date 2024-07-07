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
 