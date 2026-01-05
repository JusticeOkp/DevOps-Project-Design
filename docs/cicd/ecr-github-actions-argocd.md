# CI/CD and GitOps Flow (ECR + GitHub Actions + Argo CD)

This document describes the end-to-end CI/CD workflow used in this project to build, publish, and deploy container images to an AWS EKS cluster using GitHub Actions and Argo CD.

## Overview

The pipeline follows a production-style separation of concerns:

- CI is responsible for building and publishing container images
- CD is handled via GitOps using Argo CD
- Kubernetes manifests never build images
- The cluster only pulls immutable images from Amazon ECR

## CI: GitHub Actions

### Trigger conditions

The CI pipeline is triggered on pushes to the branch:

- feature/phase-1-terraform-bootstrap

And only when files under the following paths change:

- app/hello/**
- .github/workflows/ci-ecr-push.yml

This ensures CI runs only when application or pipeline code changes.

### Build and push process

GitHub Actions performs the following steps:

1. Checks out the repository
2. Configures AWS credentials using repository secrets
3. Authenticates to Amazon ECR
4. Builds the Docker image from app/hello
5. Pushes the image to ECR

### Image tagging strategy

Images are tagged using the full Git commit SHA:

- This guarantees immutability
- Enables easy rollback
- Provides traceability from running pod to source commit

Example image tag:

692167434250.dkr.ecr.us-east-1.amazonaws.com/devops-project-design/hello:2229cd661e34c26bca8176d5b01da48aa9eca62c

## Container Registry (ECR)

The image is published to the following Amazon ECR repository:

- Repository: devops-project-design/hello
- Region: us-east-1
- Scan-on-push enabled
- Lifecycle policy retains the most recent images only

The repository is provisioned using Terraform as part of the dev environment.

## CD: GitOps with Argo CD

### Deployment model

Argo CD continuously monitors this repository and applies Kubernetes manifests from:

k8s/apps/overlays/dev/hello

The overlay uses Kustomize to rewrite the container image reference.

### Image promotion mechanism

The base Deployment references a generic image:

image: nginx:1.27

The dev overlay replaces it with the ECR image and Git commit SHA:

- newName: 692167434250.dkr.ecr.us-east-1.amazonaws.com/devops-project-design/hello
- newTag: <git-sha>

This ensures that deployments are driven purely by Git state.

### Sync behavior

- Argo CD automatically detects changes in Git
- The application syncs and rolls out changes to the cluster
- No kubectl apply is required for deployments

## Verification steps

The following commands were used to validate the pipeline end-to-end:

Confirm image exists in ECR:

aws ecr describe-images \
  --repository-name devops-project-design/hello \
  --region us-east-1

Confirm Argo desired state:

kubectl -n argocd get application hello-dev -o jsonpath='{.status.summary.images}'

Confirm live deployment image:

kubectl -n dev get deploy hello \
  -o jsonpath='{.spec.template.spec.containers[0].image}'

Confirm rollout success:

kubectl -n dev rollout status deploy/hello

## Result

A successful change to application code results in:

- A new immutable image built in CI
- Image published to ECR
- GitOps-based deployment via Argo CD
- Automatic rollout in EKS with no manual intervention

