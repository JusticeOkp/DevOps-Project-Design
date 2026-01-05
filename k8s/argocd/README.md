# Argo CD (Dev)

Argo CD is used as the GitOps control plane for this project.

## Install
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Verify
kubectl -n argocd get pods
kubectl -n argocd rollout status deploy/argocd-server

Access UI (local)
kubectl -n argocd port-forward svc/argocd-server 8080:443

Open: https://localhost:8080

Initial admin password
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 --decode; echo
