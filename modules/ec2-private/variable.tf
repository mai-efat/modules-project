
variable "instance_type" {
  description = "Instance type (e.g., t2.micro)"
  type        = string
  default     = "t2.micro"  # Default instance type
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
