/*########################################################
Main EKS Cluster Permissions

Permissions:
    elasticloadbalancing:DescribeLoadBalancers
    ec2:DescribeSecurityGroups
    ec2:DescribeInstances

Required to create load balancers service for deployments

########################################################*/
resource "aws_iam_policy" "VTC_Service-EKS-ELB-Policy" {
  // EKS cluster permission
  name        = lower("${var.project_name}-VTC_Service-EKS-ELB-Policy")
  description = "Policy to allow EKS to describe ELB resources"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "elasticloadbalancing:DescribeLoadBalancers",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeInstances"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "VTC_Service-EKS-ELB-Policy-Attachment" {
  // Policy Attachment for EKS ELB
  role       = module.VTC-Service-EKS_Cluster.cluster_iam_role_name
  policy_arn = aws_iam_policy.VTC_Service-EKS-ELB-Policy.arn
}


/*########################################################
AWS Load Balancer Controller Policy

Required to create load balancers service for deployments

Versions:
    Provided IAM Policy: v2.7.2
    Image tag: v2.8.1

Refer to https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

########################################################*/
data "aws_iam_policy_document" "VTC_Service-AWS-EKS-Load-Balancer-Controller-Assume_Role-Policy" {
  // Assume Role Policy For AWS EKS Load Balancer Controller
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${module.VTC-Service-EKS_Cluster.oidc_provider}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [module.VTC-Service-EKS_Cluster.oidc_provider_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "VTC_Service-AWS-EKS-Load-Balancer-Controller" {
  // Role for AWS EKS Load Balancer Controller
  name               = "${var.project_name}-AWS-EKS-Load-Balancer-Controller"
  assume_role_policy = data.aws_iam_policy_document.VTC_Service-AWS-EKS-Load-Balancer-Controller-Assume_Role-Policy.json
}

resource "aws_iam_role_policy_attachment" "VTC_Service-AWS-EKS-Load-Balancer-Controller-Policy-Attachment" {
  // Policy Attachment for AWS EKS Load Balancer Controller Role
  role       = aws_iam_role.VTC_Service-AWS-EKS-Load-Balancer-Controller.name
  policy_arn = aws_iam_policy.VTC_Service-AWS-EKS-Load-Balancer-Controller-Policy.arn
}

resource "aws_iam_policy" "VTC_Service-AWS-EKS-Load-Balancer-Controller-Policy" {
  // Policy for AWS EKS Load Balancer Controller
  name        = lower("${var.project_name}-VTC_Service-AWS-EKS-Load-Balancer-Controller-Policy")
  description = "Policy for EKS AWS load balancer controller"
  policy      = file("./AWS-Load-Balancer-Controller-Policy.json")
}
