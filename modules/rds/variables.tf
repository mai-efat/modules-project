variable "allocated_storage" {
  description = "The amount of storage (in gigabytes) to allocate for the database."
  type        = number
  default     = 20  # Default value is 20 GB
}

variable "storage_type" {
  description = "The storage type for the database instance."
  type        = string
  default     = "gp2"  # Default to general-purpose SSD
}

variable "db_instance_class" {
  description = "The instance type of the database (e.g., db.t3.micro)."
  type        = string
  default     = "db.t3.micro"  # Default to db.t3.micro instance class
}

variable "engine" {
  description = "The name of the database engine to use (e.g., mysql, postgres)."
  type        = string
  default     = "mysql"  # Default to MySQL engine
}

variable "engine_version" {
  description = "The version of the database engine to use."
  type        = string
  default     = "8.0"  # Default to MySQL version 8.0
}

variable "db_name" {
  description = "The name of the database to create."
  type        = string
  default     = "mysqldatabase"  # Default database name
}

variable "username" {
  description = "The username for the database."
  type        = string
  default     = "admin"  # Default database username
}

variable "password" {
  description = "The password for the database."
  type        = string
  sensitive   = true
  default     = "password"  # Default password
}

variable "parameter_group_name" {
  description = "The DB parameter group to associate with the DB instance."
  type        = string
  default     = "default.mysql8.0"  # Default parameter group for MySQL 8.0
}

variable "multi_az" {
  description = "Whether to create a Multi-AZ deployment."
  type        = bool
  default     = false  # Default to false (single AZ)
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible."
  type        = bool
  default     = false  # Default to false (private instance)
}





variable "tags" {
  description = "A map of tags to assign to the RDS instance."
  type        = map(string)
  default     = {
    Environment = "development"  # Default tag for environment
    Project     = "rds"    # Default tag for project
  }
}



variable "backup_retention_period" {
  description = "The number of days to retain backups for the database."
  type        = number
  default     = 7  # Default to 7 days of backup retention
}



variable "iam_roles" {
  description = "The list of IAM roles to associate with the DB instance."
  type        = list(string)
  default     = []  # Default to no IAM roles
}
variable "vpc_id" {
  description = "The ID of the VPC where the RDS instance resides"
  type        = string
}
variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}