output "state_bucket_name" {
  description = "S3 bucket used for Terraform remote state"
  value       = aws_s3_bucket.tf_state.bucket
}

output "lock_table_name" {
  description = "DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.tf_locks.name
}

output "aws_region" {
  description = "AWS region where bootstrap resources were created"
  value       = var.aws_region
}
