/*########################################################
Locals

Ref:
    50_5-k8s_moodle.tf: Kubenates Moodle locals

########################################################*/
locals {
  VTC-Service-EKS-Cluster-Name           = "${var.project_name}-VTC_Service"
}
