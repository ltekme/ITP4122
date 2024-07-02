##########################################################
# Terraform Variables
##########################################################
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "ITP4122"
}

variable "gke-region" {
  description = "Region Deployed"
  type        = string
  default     = "us-central1"
}



##########################################################
# Context Based Terraform Variables
##########################################################
variable "gcp-project_id" {
  description = "GCP project ID"
  type        = string
}