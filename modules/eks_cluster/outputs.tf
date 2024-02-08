output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_oidc_arn" {
  value = aws_iam_role.eks_oidc.arn
}