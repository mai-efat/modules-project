resource "aws_db_instance" "default" {
  # Database settings
 
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  instance_class       = var.db_instance_class
  engine               = var.engine
  engine_version       = var.engine_version
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  multi_az             = var.multi_az
  publicly_accessible  = var.publicly_accessible
  backup_retention_period = var.backup_retention_period
    skip_final_snapshot     = true
     


  
  # Networking
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = var.tags

  
}
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow database access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"] # Adjust CIDR to your needs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "private-subnet-group"
  subnet_ids = var.private_subnet_ids # Reference the private subnet IDs
  
  tags = {
    Name = "DB Subnet Group"
  }
}





