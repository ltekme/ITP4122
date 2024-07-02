/* #######################################################
Main EKS Cluster Permissions

########################################################*/


resource "aws_iam_policy" "VTC_Service-EKS-ELB-Permission" {
  name        = lower("${var.project_name}-VTC_Service-EKS-ELB-Permission")
  description = "Policy to allow EKS to describe ELB resources"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
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

resource "aws_iam_role_policy_attachment" "VTC_Service-EKS-ELB-Permission-Attachment" {
  role       = module.VTC-Service-EKS_Cluster.cluster_iam_role_name
  policy_arn = aws_iam_policy.VTC_Service-EKS-ELB-Permission.arn
}