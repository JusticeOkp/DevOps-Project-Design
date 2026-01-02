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

variable "kubernetes_version" {
  description = "EKS Kubernetes version."
  type        = string
  default     = "1.29"
}

variable "node_instance_types" {
  description = "EC2 instance types for the node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired node count."
  type        = number
  default     = 1
}

variable "node_min_size" {
  description = "Min node count."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Max node count."
  type        = number
  default     = 2
}

variable "node_disk_size" {
  description = "Node disk size in GiB."
  type        = number
  default     = 20
}
