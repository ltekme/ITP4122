##########################################################
# Local Execute
##########################################################
resource "null_resource" "update_kubeconfig" {
  // Update Local Kubectl Config
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${var.aws-region} --name ${module.VTC-Service-EKS_Cluster.cluster_name} && echo 'Updated EKS Kubectl credentials'"
  }
  
  depends_on = [
    module.VTC-Service-EKS_Cluster
  ]
}