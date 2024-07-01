##########################################################
# AWS Terraform Provider
#
# Default Tags on resources:
#   Created_by: "Terrafrom"
#   Project:    var.project_name
##########################################################
provider "aws" {
  default_tags {
    tags = {
      Created_by = "Terrafrom"
      Project    = var.project_name
    }
  }
  region = var.aws-region
}


##########################################################
# Current AWS Caller Identy
##########################################################
data "aws_caller_identity" "current" {}
