vpc_id = "vpc-0f4e69777b2f94944"
web_security_group_name_prefix = "web-layer"
web_security_group_description = "Web Layer security group"
web_ingress_rules = [
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

app_security_group_name_prefix = "app-layer"
app_security_group_description = "App Layer security group"
app_ingress_rules = [
  {
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
]