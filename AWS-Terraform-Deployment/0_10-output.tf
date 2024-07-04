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