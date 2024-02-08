terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "private_subnets" {
  source             = "../modules/private_subnets"
  subnet_name_prefix = var.subnet_name_prefix
  availability_zones = var.availability_zones
  cidr_blocks        = var.cidr_blocks
  vpc_id             = var.vpc_id
  public_subnet_1_id = var.public_subnet_1_id
  nat_gateway_name   = var.nat_gateway_name
  route_table_name   = var.route_table_name
}

module "eks_security_group_1" {
  source        = "../modules/security_groups"
  name_prefix   = var.eks_security_group_1_name_prefix
  ingress_rules = var.eks_security_group_1_ingress_rules
  vpc_id        = var.vpc_id
  description   = var.eks_security_group_1_description
}

module "eks_security_group_2" {
  source        = "../modules/security_groups"
  name_prefix   = var.eks_security_group_2_name_prefix
  ingress_rules = var.eks_security_group_2_ingress_rules
  vpc_id        = var.vpc_id
  description   = var.eks_security_group_2_description
}

module "eks_nodegroup_security_group" {
  source        = "../modules/security_groups"
  name_prefix   = var.eks_nodegroup_security_group_name_prefix
  ingress_rules = var.eks_nodegroup_security_group_ingress_rules
  vpc_id        = var.vpc_id
  description   = var.eks_nodegroup_security_group_description
}

module "iam_roles" {
  source                      = "../modules/iam"
  eks_cluster_iam_role_name   = var.eks_cluster_iam_role_name
  eks_nodegroup_iam_role_name = var.eks_nodegroup_iam_role_name
}

module "eks_cluster" {
  source                   = "../modules/eks_cluster"
  eks_cluster_name         = var.eks_cluster_name
  eks_version              = var.eks_version
  eks_cluster_iam_role_arn = module.iam_roles.eks_cluster_iam_role_arn
  eks_security_group_1_id  = module.eks_security_group_1.security_group_id
  eks_security_group_2_id  = module.eks_security_group_2.security_group_id
  vpc_id                   = var.vpc_id
  private_subnet_ids       = module.private_subnets.private_subnet_ids
}

module "eks_nodegroups" {
  source                          = "../modules/eks_nodegroups"
  eks_cluster_name                = var.eks_cluster_name
  ec2_ssh_key                     = var.ec2_ssh_key
  eks_nodegroup_name              = var.eks_nodegroup_name
  eks_nodegroup_ami_type          = var.eks_nodegroup_ami_type
  eks_nodegroup_disk_size         = var.eks_nodegroup_disk_size
  eks_nodegroup_instance_type     = var.eks_nodegroup_instance_type
  eks_nodegroup_security_group_id = module.eks_nodegroup_security_group.security_group_id
  eks_nodegroup_iam_role_arn      = module.iam_roles.eks_nodegroup_iam_role_arn
  eks_nodegroup_desired_size      = var.eks_nodegroup_desired_size
  eks_nodegroup_maximum_size      = var.eks_nodegroup_maximum_size
  eks_nodegroup_minimum_size      = var.eks_nodegroup_minimum_size
  vpc_id                          = var.vpc_id
  private_subnet_ids              = module.private_subnets.private_subnet_ids
  eks_addons                      = var.eks_addons
}

module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.14"

  cluster_name      = var.eks_cluster_name
  cluster_endpoint  = module.eks_cluster.eks_cluster_endpoint
  cluster_version   = var.eks_version
  oidc_provider_arn = module.eks_cluster.eks_oidc_arn

  enable_kube_prometheus_stack        = true
  enable_metrics_server               = true
  enable_aws_node_termination_handler = true
  enable_aws_load_balancer_controller = true
  enable_external_secrets             = true
  enable_external_dns                 = true
}