vpc_id                           = "vpc-0f4e69777b2f94944"
public_subnet_1_id               = "subnet-05039cf18cd64747b"
cidr_blocks                      = ["10.2.3.0/24", "10.2.4.0/24"]
availability_zones               = ["ap-south-1a", "ap-south-1b"]
subnet_name_prefix               = "eks-private-subnet"
nat_gateway_name                 = "eks-nat-gateway"
route_table_name                 = "eks-route-table"
eks_security_group_1_name_prefix = "eks-security-group-1"
eks_security_group_1_description = "EKS Cluster Security Group 1"
eks_security_group_1_ingress_rules = [
  {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

eks_security_group_2_name_prefix = "eks-security-group-2"
eks_security_group_2_description = "EKS Cluster Security Group 1"
eks_security_group_2_ingress_rules = [
  {
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
eks_cluster_iam_role_name                = "EKSClusterIAMRole"
eks_nodegroup_iam_role_name              = "EKSNodeGroupsIAMRole"
eks_cluster_name                         = "test-cluster"
eks_version                              = "1.28"
eks_addons                               = ["kube-proxy", "coredns", "vpc-cni"]
eks_nodegroup_security_group_name_prefix = "eks-nodegroup-security-group"
eks_nodegroup_security_group_description = "EKS Cluster Nodegroup Security Group"
eks_nodegroup_security_group_ingress_rules = [
  {
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
ec2_ssh_key                 = "cf-server"
eks_nodegroup_name          = "eks-cluster-nodegroup"
eks_nodegroup_ami_type      = "AL2_x86_64"
eks_nodegroup_disk_size     = "30"
eks_nodegroup_instance_type = ["t3.small"]
eks_nodegroup_desired_size  = 2
eks_nodegroup_minimum_size  = 1
eks_nodegroup_maximum_size  = 3
