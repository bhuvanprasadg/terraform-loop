variable "vpc_id" {
  description = "VPC Id for EKS Cluster"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet Ids in both the Availability Zones for EKS Cluster"
  type        = list(string)
}

variable "eks_cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "eks_version" {
  description = "EKS Version"
  type        = number
}

variable "eks_cluster_iam_role_arn" {
  type        = string
  description = "EKS Cluster IAM Role ARN"
}

variable "eks_security_group_1_id" {
  type        = string
  description = "EKS security group 1 id"
}

variable "eks_security_group_2_id" {
  type        = string
  description = "EKS security group 2 id"
}