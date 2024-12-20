variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}