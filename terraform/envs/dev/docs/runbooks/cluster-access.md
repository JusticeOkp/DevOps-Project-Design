# EKS Cluster Access (Dev)

This runbook documents how to access and verify the dev EKS cluster.

## Prerequisites
- AWS CLI configured with sufficient permissions
- kubectl installed

## Update kubeconfig
```bash
aws eks update-kubeconfig \
  --region us-east-1 \
  --name devops-project-design-eks-dev

