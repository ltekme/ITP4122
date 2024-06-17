variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "ITP4122"
}

variable "aws_region" {
  description = "Region Deployed"
  type        = string
  default     = "us-east-1"
}

variable "eks_access_role" {
  description = "Role that EKS Access Entry Use"
  type        = string
}