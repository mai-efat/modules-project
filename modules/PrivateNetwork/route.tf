resource "aws_route_table" "private" {
  vpc_id = var.vpc_id  # Refer to your VPC ID

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id  # Route traffic to NAT Gateway
  }
  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr_blocks)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}