variable "cidr_blocks" {
  description = "List of Subnet CIDR blocks"
  type        = list(string)
}
variable "vpc_id" {
  description = "VPC Id of the subnets"
  type        = string
}
variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
}
variable "subnet_name_prefix" {
  description = "Subnet Name prefix"
  type        = string
}
variable "public_subnet_1_id" {
  type = string
  description = "Public Subnet 1 Id"
}
variable "nat_gateway_name" {
  type = string
  description = "Name of the NAT Gateway"
}
variable "route_table_name" {
  type = string
  description = "Route table name"
}