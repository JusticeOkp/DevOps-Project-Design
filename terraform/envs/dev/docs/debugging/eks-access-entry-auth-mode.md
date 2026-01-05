EKS AccessEntry failure — authentication mode required

Error (what failed & when)
During terraform apply, creation of aws_eks_access_entry failed with:
InvalidRequestException: The cluster's authentication mode must be set to one of [API, API_AND_CONFIG_MAP].

This occurred after the EKS cluster and managed node group were created, at the access-entry step.
Root cause (why it failed)

The EKS cluster was using the default CONFIG_MAP-only authentication mode, which does not support the EKS Access Entry API. Access Entries require API-based authentication to be enabled on the cluster.
Fix (what changed)
Updated the EKS cluster configuration to explicitly enable API-based authentication by adding:

access_config {
  authentication_mode                         = "API_AND_CONFIG_MAP"
  bootstrap_cluster_creator_admin_permissions = true
}
Re-ran terraform apply. The cluster was replaced to apply the new authentication mode, after which aws_eks_access_entry and aws_eks_access_policy_association were created successfully.

Why the fix works
AWS EKS requires the cluster authentication mode to include API in order to use the Access Entry API.
API_AND_CONFIG_MAP enables both modern API-based access control and the legacy aws-auth ConfigMap, allowing the operation to succeed.

Lessons learned / best practices
Changing access_config.authentication_mode is destructive and forces cluster replacement; plan maintenance windows accordingly.
Back up manifests, Helm releases, and persistent volumes before applying changes that recreate the control plane.
For non-destructive access management, the aws-auth ConfigMap can be used as a temporary alternative.
If cluster deletion is blocked, destroy managed node groups first to keep Terraform state consistent.

Outcome
After applying the fix, EKS access entries were created successfully and cluster admin access was restored. Control plane downtime occurred during replacement, as expected.

Verification
aws eks update-kubeconfig --region us-east-1 --name devops-project-design-eks-dev
kubectl get nodes

Result:
kubeconfig updated successfully
node(s) in Ready state

