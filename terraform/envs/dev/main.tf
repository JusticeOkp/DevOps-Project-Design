module "vpc" {
  source = "../../modules/vpc"

  project_name  = var.project_name
  vpc_cidr      = var.vpc_cidr
  az_count      = var.az_count
  cluster_name  = var.cluster_name
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
