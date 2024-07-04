/*########################################################
Terraform

########################################################*/
terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.48.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.14.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1"
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
    host                   = local.VTC-Service-EKS-Cluster-Endpoint
    cluster_ca_certificate = base64decode(local.VTC-Service-EKS-Cluster-CA-Certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", local.VTC-Service-EKS-Cluster-Name]
      command     = "aws"
    }
  }
}


/*########################################################
Kubernates Provider for EKS Cluster

########################################################*/
provider "kubernetes" {
  host                   = local.VTC-Service-EKS-Cluster-Endpoint
  cluster_ca_certificate = base64decode(local.VTC-Service-EKS-Cluster-CA-Certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", local.VTC-Service-EKS-Cluster-Name]
    command     = "aws"
  }
}


/*########################################################
Current AWS Caller Identy

########################################################*/
data "aws_caller_identity" "current" {}
