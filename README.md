# ITP4122

For additional documentation, check out the [docs](/docs) directory.

## Requirements

- kubectl == 1.30
- Terraform
- AWS CLI

If built from a dev container/Codespace, the requirements should already be met.

## Configuring kubectl

To configure kubectl for accessing an Amazon EKS cluster, use the following command:

```bash
aws eks update-kubeconfig --region us-east-1 --name ITP4122-VTC_Service
```

## Useful Aliases for Kubernetes

```bash
alias kg="kubectl get"
# Usage: kg pods
alias k="kubectl"
# Usage: k version
```
