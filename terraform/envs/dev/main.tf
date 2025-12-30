terraform {
  # Environment entrypoint.
  # Phase 1 will wire in the VPC + EKS modules here.
}

# Placeholder outputs to confirm backend wiring works.
output "env_name" {
  value = "dev"
}
