variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "ec2_instance_ids_public" {
  description = "List of EC2 instance IDs to attach to the ELB target group"
  type        = list(string)  # Expecting a list of EC2 instance IDs
}
variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)  # This defines the variable as a list of strings (subnet IDs)
}

variable "public_security_group_id" {
  description = "The security group ID for the public ELB"
  type        = string
}

