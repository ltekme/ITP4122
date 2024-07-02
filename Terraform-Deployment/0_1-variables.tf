##########################################################
# Terraform Variables
##########################################################
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "ITP4122"
}

variable "eks-cluster-name" {
  description = "EKS Cluster Name for VTC_Service Cluster"
  type        = string
  default     = "ITP4122-VTC_Service"
}

variable "aws-region" {
  description = "Region Deployed"
  type        = string
  default     = "us-east-1"
}

variable "rds-master-user" {
  description = "RDS Master Username - TO BE CHANGED"
  type        = string
  default     = "itp4122"
}

variable "rds-master-password" {
  description = "RDS Master Password - TO BE CHANGED"
  type        = string
  default     = "itp4122_master_db"
}


##########################################################
# Context Based Terraform Variables
##########################################################
variable "eks-access-role-arn" {
  description = "Role ARN For EKS ADMIN Access Entry"
  type        = string
}
