variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "ec2_instance_ids-private" {
  description = "The list of EC2 instance IDs to attach to the target group"
  type        = list(string)
}
variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}
variable "private_security_group_id" {
  description = "The security group ID for the public ELB"
  type        = string
}
