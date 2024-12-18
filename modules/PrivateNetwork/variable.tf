
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets_cidr_blocks" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "public_subnet_id" {
  description = "The public subnet ID for the NAT Gateway"
  type        = string
}

