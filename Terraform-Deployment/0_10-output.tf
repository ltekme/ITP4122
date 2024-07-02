##########################################################
# Outputs
##########################################################
output "EKS-Kubectl-Update-Config" {
    value = "aws eks update-kubeconfig --region ${var.aws-region} --name ${module.VTC-Service-EKS_Cluster.cluster_name}"
}