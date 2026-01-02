variable "aws_region" {
  description = "AWS region for dev environment."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for tagging and resource naming."
  type        = string
  default     = "devops-project-design"
}

variable "cluster_name" {
  description = "EKS cluster name (used for subnet tags)."
  type        = string
  default     = "devops-project-design-eks-dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR for dev."
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of AZs to use."
  type        = number
  default     = 2
}
