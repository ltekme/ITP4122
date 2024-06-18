resource "aws_efs_file_system" "app_data" {
  encrypted = true
  lifecycle_policy {
    transition_to_ia = "AFTER_365_DAYS"
  }
}

resource "aws_efs_mount_target" "AZ1" {
  file_system_id = aws_efs_file_system.app_data.id
  subnet_id      = module.vpc.private_subnets[0]
}

resource "aws_efs_mount_target" "AZ2" {
  file_system_id = aws_efs_file_system.app_data.id
  subnet_id      = module.vpc.private_subnets[1]
}
