variable "project_name" {
  type        = string
  description = "Project name for tagging."
}

variable "github_owner" {
  type        = string
  description = "GitHub org/user that owns the repo (e.g., JusticeOkp)."
}

variable "github_repo" {
  type        = string
  description = "GitHub repo name (e.g., DevOps-Project-Design)."
}

variable "allowed_branches" {
  type        = list(string)
  description = "Branches allowed to assume the role (e.g., [\"main\"])."
  default     = ["main"]
}

variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

variable "ecr_repository_arn" {
  type        = string
  description = "ARN of the ECR repository the workflow can push to."
}
