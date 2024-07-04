/*########################################################
Terraform Requiements

########################################################*/
terraform {
  required_version = ">= 1.9.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.57.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.14.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
  }
}


/*########################################################
AWS Terraform Provider

Default Tags on resources:
    Created_by: "Terrafrom"
    Project:    var.project_name

########################################################*/
provider "aws" {
  default_tags {
    tags = {
      Created_by = "Terrafrom"
      Project    = var.project_name
    }
  }
  region = var.aws-region
}


/*########################################################
Helm Terraform Provider FOr EKS CLuster

########################################################*/
provider "helm" {
  kubernetes {
    host                   = module.VTC-Service-EKS_Cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.VTC-Service-EKS_Cluster.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", local.VTC-Service-EKS-Cluster-Name, "--region", var.aws-region]
      command     = "aws"
    }
  }
}


/*########################################################
Terraform Providers setup

Providers:
    Kubernates

########################################################*/
provider "kubernetes" {
  host                   = module.VTC-Service-EKS_Cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.VTC-Service-EKS_Cluster.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.VTC-Service-EKS_Cluster.cluster_name, "--region", var.aws-region]
    command     = "aws"
  }
}


/*########################################################
Current AWS Caller Identy

########################################################*/
data "aws_caller_identity" "current" {}
