variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "web_security_group_name_prefix" {
  description = "Prefix for the web security group name"
  type        = string
}

variable "web_security_group_description" {
  description = "Web description"
  type        = string
}

variable "web_ingress_rules" {
  description = "List of ingress rules for the web security group"
  type        = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "app_security_group_name_prefix" {
  description = "Prefix for the app security group name"
  type        = string
}

variable "app_security_group_description" {
  description = "App description"
  type        = string
}

variable "app_ingress_rules" {
  description = "List of ingress rules for the app security group"
  type        = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}