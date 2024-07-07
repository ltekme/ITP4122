# ITP4122

## Additional Docs

refer to [/docs](docs/README.md)

## Quick Create Command

```sh
cd AWS-Terraform-Deployment && terraform init && terraform apply -auto-pprove
```

## Delete k8s resource before destroy cluster

Due to some dependency reasons, kubernates terraform provider cannot be used to provision resources.

Instead, Kubectl provider is used and k8s resources are "kubectl apply -f"ed directly.

Before the destroy of this infrasecture, a few commands are required to be executed.

```sh
kubectl delete all -n default
```

This command delete all resources in the default namespace.

```sh
kubectl delete namespace moodle
```

This command delete the namespace moodle along with resources inside.

After Applying these commands. Wait for 5-10 min for AWS load balancer controller to remove the ALB created by k8s.

## Manual Deleteion of mysql db state

Manual deletion of a the mysql tf state is also needed. Execute the command below before terraform destroy.

- terraform state rm 'mysql_database.VTC_Service-Moodle'

  This command removes the TF state for the database created for moodle.

In most cases, when executing terraform destroy. This resource deletion timeout. Possablly caused by RDS beign deleted before this finishes.

## Default Moodle Username and Password

- Username: user
- Password: bitnami