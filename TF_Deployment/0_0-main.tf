provider "aws" {
  default_tags {
    tags = {
      Created_by = "Terrafrom"
      Project    = "ITP4122-VTC_SERVICES"
    }
  }
  region = var.aws_region
}

terraform {
  required_providers {
    temporary = {
      source  = "kota65535/temporary"
      version = "0.2.0"
    }
  }
}
provider "temporary" {
  base = "/tmp"
}


data "aws_caller_identity" "current" {}