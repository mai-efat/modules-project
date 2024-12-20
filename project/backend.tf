
# resource "aws_dynamodb_table" "terraform_lock" {
#   name           = "terraform-lock-table"
#   billing_mode   = "PAY_PER_REQUEST"  # Use on-demand billing (no need to manage throughput)
#   hash_key       = "LockID"  # DynamoDB key for the lock

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name        = "Terraform Lock"
#   }
# }
terraform {
  backend "s3" {
    bucket         = "terraform-state-project-lock"  # The name of your S3 bucket
    key            = "terraform.tfstate"          # The path inside the bucket to store the state file
    region         = "us-east-1"                  # AWS region where your resources are located
    encrypt        = true                         # Encrypt the state file in S3
    dynamodb_table = "terraform-lock-table"       # The DynamoDB table for state locking
    acl            = "bucket-owner-full-control"  # Set permissions for the state file
  }
}

