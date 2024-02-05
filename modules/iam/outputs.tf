output "eks_cluster_iam_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_nodegroup_iam_role_arn" {
  value = aws_iam_role.eks_nodegroup_role.arn
}