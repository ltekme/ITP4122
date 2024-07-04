/*########################################################
Terraform Variables

########################################################*/
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "ITP4122"
}

variable "aws-region" {
  description = "Region Deployed"
  type        = string
  default     = "us-east-1"
}

variable "rds-master-user" {
  description = "RDS Master Username - TO BE CHANGED"
  type        = string
}

variable "rds-master-password" {
  description = "RDS Master Password - TO BE CHANGED"
  type        = string
}


/*########################################################
Context Based Terraform Variables

########################################################*/
variable "eks-access-role-arn" {
  description = "Role ARN For EKS ADMIN Access Entry"
  type        = string
}
