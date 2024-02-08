resource "aws_eks_cluster" "eks_cluster" {
  name                      = var.eks_cluster_name
  role_arn                  = var.eks_cluster_iam_role_arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  version                   = var.eks_version

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    security_group_ids      = [var.eks_security_group_1_id, var.eks_security_group_2_id]
  }
}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:aws-eks"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_oidc" {
  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role_policy.json
  name               = "eks-oidc"
}

data "http" "policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json"
}

data "aws_iam_policy_document" "aws_load_balancer_controller" {
  source_policy_documents = [data.http.policy.response_body]

  statement {
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress"
    ]
    resources = ["*"]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/kubernetes.io/cluster/${var.eks_cluster_name}"
      values   = ["false"]
    }
  }
  depends_on = [
    data.http.policy
  ]
}

resource "aws_iam_policy" "eks_alb_policy" {
  name        = "eks-alb-policy"
  description = "AWS Loadbalancer controller policy"
  policy      = data.aws_iam_policy_document.aws_load_balancer_controller.json

  depends_on = [ data.aws_iam_policy_document.aws_load_balancer_controller ]
}

resource "aws_iam_role_policy_attachment" "eks_attach" {
  role       = aws_iam_role.eks_oidc.name
  policy_arn = aws_iam_policy.eks_alb_policy.arn
}