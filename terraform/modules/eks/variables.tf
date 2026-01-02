variable "project_name" {
  description = "Project name for tagging."
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EKS will be deployed."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS control plane and nodes."
  type        = list(string)
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version."
  type        = string
  default     = "1.29"
}

variable "node_instance_types" {
  description = "EC2 instance types for managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired number of nodes."
  type        = number
  default     = 1
}

variable "node_min_size" {
  description = "Minimum number of nodes."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of nodes."
  type        = number
  default     = 2
}

variable "node_disk_size" {
  description = "Node root volume size (GiB)."
  type        = number
  default     = 20
}
