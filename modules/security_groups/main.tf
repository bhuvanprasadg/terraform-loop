resource "aws_security_group" "security_group" {
  name        = "${var.name_prefix}-sg"
  vpc_id      = var.vpc_id
  description = var.description

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "security_group_ingress_rule" {
  count = length(var.ingress_rules)

  security_group_id = aws_security_group.security_group.id

  type        = var.ingress_rules[count.index].type
  from_port   = var.ingress_rules[count.index].from_port
  to_port     = var.ingress_rules[count.index].to_port
  protocol    = var.ingress_rules[count.index].protocol
  cidr_blocks = var.ingress_rules[count.index].cidr_blocks
}
