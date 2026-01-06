module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  az_count     = var.az_count
  cluster_name = var.cluster_name
}

module "eks" {
  source = "../../modules/eks"

  project_name       = var.project_name
  cluster_name       = var.cluster_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  kubernetes_version  = var.kubernetes_version
  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  node_disk_size      = var.node_disk_size
}

module "ecr_hello" {
  source = "../../modules/ecr"

  project_name = var.project_name
  repo_name    = "${var.project_name}/hello"
}

output "env_name" {
  value = "dev"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_oidc_issuer_url" {
  value = module.eks.oidc_issuer_url
}

output "hello_ecr_repository_url" {
  value = module.ecr_hello.repository_url
}

output "hello_ecr_repository_arn" {
  value = module.ecr_hello.repository_arn
}
