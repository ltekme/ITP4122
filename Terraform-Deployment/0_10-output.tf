##########################################################
# Outputs
##########################################################
output "EKS-Kubectl-Update-Config" {
    value = "aws eks update-kubeconfig --region ${var.aws-region} --name ${module.eks.cluster_name}"
}