resource "aws_eks_node_group" "eks_nodegroup" {
  node_group_name = var.eks_nodegroup_name
  cluster_name    = var.eks_cluster_name
  node_role_arn   = var.eks_nodegroup_iam_role_arn
  subnet_ids      = var.private_subnet_ids

  ami_type       = var.eks_nodegroup_ami_type
  capacity_type  = "ON_DEMAND"
  disk_size      = var.eks_nodegroup_disk_size
  instance_types = var.eks_nodegroup_instance_type

  remote_access {
    ec2_ssh_key               = var.ec2_ssh_key
    source_security_group_ids = [var.eks_nodegroup_security_group_id]
  }

  scaling_config {
    desired_size = var.eks_nodegroup_desired_size
    min_size     = var.eks_nodegroup_minimum_size
    max_size     = var.eks_nodegroup_maximum_size
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name = var.eks_nodegroup_name
  }
}

resource "aws_eks_addon" "addons" {
  count = length(var.eks_addons)

  cluster_name  = var.eks_cluster_name
  addon_name    = var.eks_addons[count.index]
  depends_on    = [aws_eks_node_group.eks_nodegroup]
}