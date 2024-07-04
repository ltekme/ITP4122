/*########################################################
Locals

########################################################*/
locals {
  VTC-Service-EKS-Cluster-Endpoint       = module.VTC-Service-EKS_Cluster.cluster_endpoint
  VTC-Service-EKS-Cluster-CA-Certificate = module.VTC-Service-EKS_Cluster.cluster_certificate_authority_data
  VTC-Service-EKS-Cluster-Name           = "${var.project_name}-VTC_Service"
}
