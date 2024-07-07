/*########################################################
AWS EFS Storage File System

########################################################*/
resource "aws_efs_file_system" "VTC_Service-EFS-File_System" {
  availability_zone_name = "${var.aws-region}a"
  performance_mode = "generalPurpose"
  encrypted        = true
  throughput_mode = "bursting"
}


/*########################################################
AWS EFS Storage Mount Target

########################################################*/
resource "aws_efs_mount_target" "VTC_Service-EFS-File_System-Mount-AZ_A" {
  // Mount Target in AZ A
  file_system_id = aws_efs_file_system.VTC_Service-EFS-File_System.id
  subnet_id      = aws_subnet.VTC_Service-private-AZ_A.id
}

# resource "aws_efs_mount_target" "VTC_Service-EFS-File_System-Mount-AZ_B" {
#   // Mount Target in AZ B
#   file_system_id = aws_efs_file_system.VTC_Service-EFS-File_System.id
#   subnet_id      = aws_subnet.VTC_Service-private-AZ_B.id
# }
