# CI/CD Flow: GitHub Actions → ECR → Argo CD

## Trigger
- Pipeline runs on pushes to `main`
- Limited to changes in `app/hello` or workflow files

## Build & Push
- GitHub Actions builds the Docker image
- Image is tagged with the Git commit SHA
- Authentication to AWS uses GitHub OIDC (no secrets stored)

## Registry
- Image is pushed to Amazon ECR
- Lifecycle policy limits retained images

## Deployment
- Argo CD monitors the Git repository
- Kustomize overlay defines the target image
- Kubernetes performs a rolling update

## Verification
```bash
kubectl -n argocd get applications
kubectl -n dev rollout status deploy/hello
kubectl -n dev get deploy hello -o jsonpath='{.spec.template.spec.containers[0].image}'
