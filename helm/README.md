# HELM CHARTS DEPLOYMENTS

The helm directory is the illustration of a repository containing templated helm charts for deploying docker applications on kubernetes using Terraform. In a real production environment this should be stored under a dedicated repo.

Terraform was used in this case to statisfy the requirements of the "topcon challenge". However in a real production environment environment I would recomend leveraging a GitOps approach using tools like `ArgoCD` or `Flux`.

## Helm Charts Description

| Helm Chart         | Type          | Description                                         | Ref Source                                                    |
| ------------------ | ------------- | --------------------------------------------------- | ------------------------------------------------------------- |
| bitnami/wordpress  | Application   | Custom wordpress app pulling image from private ECR | https://github.com/bitnami/charts/tree/main/bitnami/wordpress |
| cluster-autoscaler | Infra service | Default cluster-autoscalaer deployment              | https://kubernetes.github.io/autoscaler /                     |
