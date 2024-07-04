/*########################################################
Local Execute

Run after EKS cluster creation:
    aws eks update-kubeconfig --region ${var.aws-region} --name ${module.VTC-Service-EKS_Cluster.cluster_name}

########################################################*/
resource "terraform_data" "update_kubeconfig" {
  // Update Local Kubectl Config
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${var.aws-region} --name ${module.VTC-Service-EKS_Cluster.cluster_name}"
  }
  
  depends_on = [
    module.VTC-Service-EKS_Cluster
  ]
}