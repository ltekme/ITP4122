/*########################################################
Main RDS cluster

########################################################*/
# resource "aws_rds_cluster" "database" {
#   # cluster_identifier      = var.cluster_identifier
#   db_subnet_group_name    = "${aws_db_subnet_group.VTC_Service-MAIN_RDS.name}"
#   vpc_security_group_ids  = var.vpc_security_group_ids
#   engine_mode             = "serverless"
#   enable_http_endpoint    = var.enable_http_endpoint
#   master_username         = var.master_username
#   master_password         = random_password.rng.result
#   database_name           = var.name
#   backup_retention_period = var.backup_retention_period
#   skip_final_snapshot     = var.skip_final_snapshot
#   deletion_protection     = var.deletion_protection
#   engine                  = "aurora-mysql"
#   engine_version          = "8.0.mysql_aurora.3.02.0"

#   serverlessv2_scaling_configuration {
#     max_capacity = var.max_capacity
#     min_capacity = var.min_capacity
#   }

#   lifecycle {
#     ignore_changes = [
#       engine_version,
#       availability_zones,
#       master_username,
#       master_password,
#     ]
#   }

#   tags = {
#     Environment = var.env
#     Name        = var.name
#   }
# }

# resource "aws_rds_cluster_instance" "cluster_instances" {
#   identifier         = "${var.cluster_identifier}-serverless"
#   cluster_identifier = aws_rds_cluster.database.id
#   instance_class     = "db.serverless"
#   engine             = aws_rds_cluster.database.engine
#   engine_version     = aws_rds_cluster.database.engine_version
# }

# resource "aws_db_subnet_group" "db_subnet_group" {
#   name       = "${var.cluster_identifier}-subnet-group"
#   subnet_ids = var.subnet_ids

#   tags = {
#     Environment = var.env
#   }
# }

# resource "random_password" "rng" {
#   length  = 16
#   special = false

#   keepers = {
#     cluster_identifier = var.cluster_identifier
#   }
# }