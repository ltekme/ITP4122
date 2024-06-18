output "EFS_Mount_Point_AZ1" {
  value = aws_efs_mount_target.AZ1.dns_name
}

output "EFS_Mount_Point_AZ2" {
  value = aws_efs_mount_target.AZ2.dns_name
}

output "EFS_File_System" {
  value = aws_efs_file_system.app_data.dns_name
}