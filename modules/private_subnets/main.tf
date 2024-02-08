resource "aws_subnet" "subnet" {
  count             = length(var.cidr_blocks)
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_blocks[count.index]
  availability_zone = element(var.availability_zones, count.index % 2)

  tags = {
    Name = "${var.subnet_name_prefix}-${count.index + 1}"
  }
}

resource "aws_eip" "eip_nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = var.public_subnet_1_id

  tags = {
    Name = var.nat_gateway_name
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = var.route_table_name
  }

}

resource "aws_route_table_association" "rt_assoc" {
  count          = length(var.cidr_blocks)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.route_table.id
}
