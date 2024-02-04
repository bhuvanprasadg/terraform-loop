variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "description" {
  description = "Description"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for the security group name"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type        = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}