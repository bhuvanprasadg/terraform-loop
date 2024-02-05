variable "vpc_id" {
  description = "vpc id for eks"
  type        = string
}

variable "eks_cluster_name" {
  description = "eks cluster name"
  type        = string
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

variable "ec2_ssh_key" {
  type        = string
  description = "ec2_ssh_key"
}

variable "eks_nodegroup_iam_role_arn" {
  type        = string
  description = "nodegroup iam role arn"
}

variable "eks_nodegroup_security_group_id" {
  type        = string
  description = "EKS node group security group id"
}

variable "private_subnet_ids" {
  description = "Private Subnet Ids in both the Availability Zones for EKS Cluster"
  type        = list(string)
}

variable "eks_nodegroup_name" {
  type = string
  description = "EKS Nodegroup name"
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

variable "eks_addons" {
  type = list(string)
  description = "EKS Addons"
}