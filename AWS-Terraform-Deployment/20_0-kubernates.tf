resource "kubernetes_manifest" "provisioning" {
  for_each = fileset("", "./EKS-Manifests/*.yaml")
  manifest = yamldecode(file(each.value))

  depends_on = [
    module.VTC-Service-EKS_Cluster,
    helm_release.aws-load-balancer-controller,
    module.aurora_mysql_v2,
  ]
}
