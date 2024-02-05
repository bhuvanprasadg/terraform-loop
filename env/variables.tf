variable "vpc_id" {
  description = "VPC Id"
  type        = string
}
variable "public_subnet_1_id" {
  description = "Public Subnet 1 Id"
  type        = string
}
variable "cidr_blocks" {
  description = "List of Subnet CIDR blocks"
  type        = list(string)
}
variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
}
variable "subnet_name_prefix" {
  description = "Subnet Name prefix"
  type        = string
}
variable "nat_gateway_name" {
  type        = string
  description = "Name of the NAT Gateway"
}
variable "route_table_name" {
  type        = string
  description = "Route table name"
}
variable "eks_security_group_1_name_prefix" {
  description = "Prefix for the EKS Security Group 1 name"
  type        = string
}
variable "eks_security_group_1_description" {
  description = "EKS Security Group 1 description"
  type        = string
}
variable "eks_security_group_1_ingress_rules" {
  description = "List of ingress rules for the EKS Security Group 1"
  type = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "eks_security_group_2_name_prefix" {
  description = "Prefix for the EKS Security Group 2 name"
  type        = string
}
variable "eks_security_group_2_description" {
  description = "EKS Security Group 2 description"
  type        = string
}
variable "eks_security_group_2_ingress_rules" {
  description = "List of ingress rules for the EKS Security Group 2"
  type = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "eks_cluster_iam_role_name" {
  description = "eks iam role name"
  type        = string
}
variable "eks_nodegroup_iam_role_name" {
  description = "eks node group iam role"
  type        = string
}
variable "eks_cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}
variable "eks_version" {
  description = "EKS Kubernetes Version"
  type        = string
}
variable "eks_addons" {
  description = "EKS Cluster addons: vpc-cni, coredns, kube-proxy"
  type        = list(string)
}

variable "eks_nodegroup_security_group_name_prefix" {
  description = "Prefix for the EKS Nodegroup Security Group name"
  type        = string
}
variable "eks_nodegroup_security_group_description" {
  description = "EKS Nodegroup Security Group description"
  type        = string
}
variable "eks_nodegroup_security_group_ingress_rules" {
  description = "List of ingress rules for the EKS Nodegroup Security Group"
  type = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "ec2_ssh_key" {
  description = "SSH Key to attach to EKS nodes"
  type = string
}

variable "eks_nodegroup_name" {
  description = "EKS Nodegroup name"
  type = string
}

variable "eks_nodegroup_ami_type" {
  description = "nodegroup ami type"
  # default = "AL2_x86_64"
  type = string
}

variable "eks_nodegroup_disk_size" {
  description = "eks nodegroup disk size"
  type        = number
}

variable "eks_nodegroup_instance_type" {
  description = "eks nodegroup instance type"
  type        = list(any)
}

variable "eks_nodegroup_desired_size" {
  type = string
  description = "EKS Nodegroup desired size"
}

variable "eks_nodegroup_minimum_size" {
  type = string
  description = "EKS Nodegroup Minimum size"
}

variable "eks_nodegroup_maximum_size" {
  type = string
  description = "EKS Nodegroup Maximum size"
}