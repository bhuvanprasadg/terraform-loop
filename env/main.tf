terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "web_security_group" {
  source        = "../modules/security_groups"
  name_prefix   = var.web_security_group_name_prefix
  ingress_rules = var.web_ingress_rules
  vpc_id        = var.vpc_id
  description   = var.web_security_group_description
}

module "app_security_group" {
  source        = "../modules/security_groups"
  name_prefix   = var.app_security_group_name_prefix
  ingress_rules = var.app_ingress_rules
  vpc_id        = var.vpc_id
  description   = var.app_security_group_description
}
