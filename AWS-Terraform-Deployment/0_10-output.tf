/*########################################################
Outputs

########################################################*/
output "EKS-Kubectl-Update-Config" {
  // Command For Updating Kubectl
  value = "aws eks update-kubeconfig --region ${var.aws-region} --name ${module.VTC-Service-EKS_Cluster.cluster_name}"
}

output "RDS-Endpoint" {
  // Aurora Endpoint
  value = module.aurora_mysql_v2.cluster_endpoint
}

output "VTC_Service-Moodle-External-Endpoint" {
  // EKS Moodle Ingress Endpoint
  value = data.external.VTC_Service-MOODLE-Ingress_8080-External_Endpoint.result.hostname
}