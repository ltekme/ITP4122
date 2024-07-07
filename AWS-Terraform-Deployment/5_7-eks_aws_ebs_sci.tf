/*########################################################
AWS EBS CSI Driver Permission

Required for Amazon EBS CSI drivers

Versions:
    IAM Role Policy Json: v0.9.0

Refer to 
    https://blog.cloudtechner.com/setting-up-efs-as-persistent-volume-for-aws-eks-d16f5f46951e
    https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/install.md

########################################################*/
data "aws_iam_policy_document" "VTC_Service-AWS-EBS-CSI-Assume_Role-Policy" {
  // Assume Role Policy For Amazon EBS CSI drivers
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${module.VTC-Service-EKS_Cluster.oidc_provider}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    principals {
      identifiers = [module.VTC-Service-EKS_Cluster.oidc_provider_arn]
      type        = "Federated"
    }
  }
}

data "aws_iam_policy_document" "VTC_Service-AWS-EBS-CSI-Encryption-Policy" {
  // Policy Document For Encripted EFS
  statement {
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:CreateGrant"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "VTC_Service-AWS-EBS-CSI-Policy" {
  // Policy for AWS EBS CSI drivers Role
  name        = lower("${var.project_name}-VTC_Service-AWS-EBS-CSI-Policy")
  description = "Policy for AWS EBS SCI Driver"
  policy      = data.aws_iam_policy_document.VTC_Service-AWS-EBS-CSI-Encryption-Policy.json

}

resource "aws_iam_role" "VTC_Service-AWS-EBS-CSI" {
  // Role for AWS EBS CSI drivers
  name               = "${var.project_name}-AWS-EBS-CSI-drivers"
  assume_role_policy = data.aws_iam_policy_document.VTC_Service-AWS-EBS-CSI-Assume_Role-Policy.json
}

resource "aws_iam_role_policy_attachment" "VTC_Service-AWS-EBS-CSI-Policy-Attachment" {
  role       = aws_iam_role.VTC_Service-AWS-EBS-CSI.name
  policy_arn = aws_iam_policy.VTC_Service-AWS-EBS-CSI-Policy.arn
}

resource "aws_iam_role_policy_attachment" "VTC_Service-AWS-EBS-CSI-Policy-Attachment-Managed" {
  role       = aws_iam_role.VTC_Service-AWS-EBS-CSI.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}
