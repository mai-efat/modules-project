
variable "instance_type" {
  description = "Instance type (e.g., t2.micro)"
  type        = string
  default     = "t2.micro"  # Default instance type
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)  # This defines the variable as a list of strings (subnet IDs)
}



