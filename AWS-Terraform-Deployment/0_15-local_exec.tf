/*########################################################
Local Execute

Run after EKS cluster creation:
    aws eks update-kubeconfig --region ${var.aws-region} --name ${module.VTC-Service-EKS_Cluster.cluster_name}

########################################################*/
resource "null_resource" "update-eks-kubeconfig" {
  // Update Local Kubectl Config
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${var.aws-region} --name ${module.VTC-Service-EKS_Cluster.cluster_name}"
  }

  depends_on = [
    module.VTC-Service-EKS_Cluster
  ]
}


/*########################################################
Delete k8s resources

########################################################*/
resource "null_resource" "VTC_Service-EKS-Default-Delete" {
  // Delete Resources in Default namespace
  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete all --all -n default && kubectl delete ingress -n default --all"
  }
}

resource "time_sleep" "VTC_Service-EKS-Default-Delete-Wait" {
  // Delete Resources in Default namespace wait
  depends_on = [null_resource.VTC_Service-EKS-Default-Delete]

  destroy_duration = "30s"
}

resource "null_resource" "VTC_Service-EKS-Moodle-Delete" {
  // Delete Resources in moodle namespace
  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete all -n moodle --all & kubectl delete ingress -n moodle --all &"
  }
}

resource "time_sleep" "VTC_Service-EKS-Moodle-Delete-Wait" {
  // Delete Resources in moodle namespace wait
  depends_on = [null_resource.VTC_Service-EKS-Moodle-Delete]

  destroy_duration = "30s"
}
