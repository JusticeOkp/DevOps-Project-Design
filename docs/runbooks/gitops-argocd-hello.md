# GitOps Verification (Argo CD + Hello App)

This runbook verifies that Argo CD is syncing manifests from GitHub into the dev namespace.

## Verify Argo CD application
```bash
kubectl -n argocd get applications
kubectl -n argocd describe application hello-dev

## Verify resources in Dev
kubectl -n dev get deploy,svc,pods

Expected:
deployment/hello Available
service/hello ClusterIP present
Notes
Initial sync may take a short time after application creation or repo updates.
If sync appears stuck, force refresh:
kubectl -n argocd annotate application hello-dev argocd.argoproj.io/refresh=hard --overwrite

