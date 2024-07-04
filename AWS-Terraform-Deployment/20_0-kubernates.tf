/*########################################################
Kubenates Manifests Provision

Note, Deployed LB require manual deletion of LB

Retry VPC Destroy are needed or manual delete are needed

########################################################*/
resource "kubectl_manifest" "provisioning" {
  for_each  = fileset("", "./EKS-Manifests/*.yaml")
  yaml_body = file(each.value)

  depends_on = [
    module.VTC-Service-EKS_Cluster,
    helm_release.aws-load-balancer-controller,
    module.aurora_mysql_v2
  ]
}
