/*########################################################
Main EKS Cluster Permissions

AWS Load Balancer Controller Install

Versions:
    Provided IAM Policy: v2.7.2
    Image tag: v2.8.1

Refer to https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

########################################################*/
resource "helm_release" "aws-load-balancer-controller" {
  // AWS Load Balancer Controller Install
  name = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set { // --set clusterName=my-cluster
    name  = "clusterName"
    value = module.VTC-Service-EKS_Cluster.cluster_name
  }

  set { // --set serviceAccount.name=aws-load-balancer-controller
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set { // --set serviceAccount.create=false
    name  = "serviceAccount.create"
    value = "false"
  }

  set { // Set image tags to prevent newer image breaking things
    name  = "image.tag"
    value = "v2.8.1"
  }

  depends_on = [
    module.VTC-Service-EKS_Cluster,
    aws_iam_role_policy_attachment.VTC_Service-AWS-EKS-Load-Balancer-Controller-Policy-Attachment
  ]
}
