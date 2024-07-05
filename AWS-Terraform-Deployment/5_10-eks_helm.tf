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

  set {
    name  = "clusterName"
    value = module.VTC-Service-EKS_Cluster.cluster_name
  }

  set {
    name  = "image.tag"
    value = "v2.8.1"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.create"
    value = true
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.VTC_Service-AWS-EKS-Load-Balancer-Controller.arn
  }

  depends_on = [
    module.VTC-Service-EKS_Cluster,
    # aws_iam_role_policy_attachment.VTC_Service-AWS-EKS-Load-Balancer-Controller-Policy-Attachment,
    # kubernetes_service_account.aws-load-balancer-controller
  ]
}
