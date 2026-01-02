# DevOps-Project-Design

Hands-on DevOps project focused on building a production-style AWS platform using Terraform, Kubernetes (EKS), GitOps, CI/CD, and basic operational practices.

## Status

- Phase 0: Repository scaffolding and standards — Completed
- Phase 1: Terraform foundation — In progress
  - Terraform bootstrap (S3 remote state + DynamoDB locking) — Completed
  - Dev environment backend configuration — Completed
  - VPC foundation (public/private subnets, single NAT gateway) — Completed

## Phase 1 – VPC Foundation (Dev)

The dev environment network was provisioned using Terraform with a simple, production-oriented design:

- One VPC across two availability zones
- Public and private subnets per AZ
- Internet Gateway for public subnets
- Single NAT Gateway for private subnet egress
- Subnets tagged for future EKS usage

### Outputs
- VPC ID
- Public subnet IDs (2)
- Private subnet IDs (2)

## Repository Structure (High Level)
terraform/
bootstrap/ # Remote state (S3 + DynamoDB)
envs/dev/ # Dev environment configuration
modules/vpc/ # Reusable VPC module
k8s/ # Kubernetes manifests (planned)
app/ # Application code (planned)
python/ # Automation scripts (planned)
docs/ # Architecture notes and runbooks


## Notes

- Infrastructure is created for learning and validation and will be torn down after the project is completed.
- The project is built incrementally, with each phase committed and documented as it progresses.

