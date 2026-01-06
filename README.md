# DevOps Project Design

A production-style DevOps platform built on AWS using Terraform, EKS, GitHub Actions, and Argo CD.  
This project demonstrates real-world infrastructure automation, CI/CD pipelines, and GitOps workflows.

---

## Overview

This repository showcases a complete DevOps workflow:

- Infrastructure provisioned with Terraform
- Containerized application built and pushed via GitHub Actions
- Secure AWS authentication using GitHub OIDC (no static credentials)
- GitOps-based deployment to Kubernetes using Argo CD

The focus is on clarity, correctness, and production-ready patterns rather than over-engineering.

---

## Architecture

**Core components:**

- **AWS VPC** – Isolated networking with public and private subnets
- **Amazon EKS** – Managed Kubernetes cluster
- **Amazon ECR** – Container image registry
- **GitHub Actions** – CI pipeline for building and pushing images
- **Argo CD** – GitOps-based continuous deployment


flowchart LR
    Dev[Developer]
    GH[GitHub Repo]
    GA[GitHub Actions]
    ECR[Amazon ECR]
    Argo[Argo CD]
    EKS[Amazon EKS]
    Dev -->|git push| GH
    GH -->|trigger| GA
    GA -->|build & push image| ECR
    GH -->|GitOps sync| Argo
    Argo -->|deploy| EKS


---

## CI/CD Flow (High Level)

1. Developer pushes code to the `main` branch
2. GitHub Actions:
   - Builds the container image
   - Tags the image with the Git commit SHA
   - Pushes the image to Amazon ECR using OIDC authentication
3. Argo CD:
   - Detects changes from the Git repository
   - Deploys the updated image to the EKS cluster
4. Kubernetes rolls out the updated application

This creates a fully automated and auditable deployment pipeline.

---

## Repository Structure

```text
.
├── app/hello                 # Containerized demo application
├── .github/workflows         # GitHub Actions CI pipelines
├── terraform
│   ├── modules               # Reusable Terraform modules (VPC, EKS, ECR, IAM)
│   └── envs/dev               # Environment-specific configuration
├── k8s
│   ├── apps                   # Kubernetes manifests (Kustomize)
│   └── argocd                 # Argo CD application definitions
├── docs
│   ├── cicd                   # CI/CD documentation
│   └── runbooks               # Operational notes and debugging
