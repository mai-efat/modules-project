# Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr_blocks)

  vpc_id            = var.vpc_id # Reference to the VPC
  cidr_block        = var.private_subnets_cidr_blocks[count.index]  # CIDR block for private subnet
  availability_zone = var.availability_zones[count.index]  # Use statically defined AZs
  map_public_ip_on_launch = false  # No public IPs on launch (private subnet)
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}



