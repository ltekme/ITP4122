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

variable "Moodle-Database-Name" {
  description = "Moodle Database Name"
  type        = string
  default     = "moodle"
}


/*########################################################
Context Based Terraform Variables

########################################################*/
variable "Moodle-Username" {
  description = "Initial Moodle Username"
  type        = string
  default     = "user"
}

variable "Moodle-Password" {
  description = "Initial Moodle Password"
  default     = "bitnami"
}

variable "eks-access-role-arn" {
  description = "Role ARN For EKS ADMIN Access Entry"
  type        = string
}

variable "rds-master-user" {
  description = "RDS Master Username"
  type        = string
}

variable "rds-master-password" {
  description = "RDS Master Password"
  type        = string
}

variable "VTC_Service-Primary-Domain" {
  description = "Domain Used by this project"
  type        = string
}
