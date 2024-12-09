# EKS INFRASTRUCTURE

The `infra` directory contains Terraform code that deploys the base infrastructure for running Kubernetes on AWS (EKS, VPC, ECR, ...).

## Base Infra Deployment

Steps to deploy the base infrastructure with Terraform.

1. Log into AWS Account with AWS cli.
```
export AWS_DEFAULT_PROFILE=<PROFILE_NAME> 
aws sso login --profile <PROFILE>
```

2. Initialise Terraform from the `infra` directory
```
terraform init
```

3. Review and apply the TF plan for "eks" module:
```
terraform plan
terraform apply
``` 
--> NOTE: The deployment will take ~15mins.

4. Update the kube config with the new cluster definition 
```
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```

The base infrastructure is now ready for deploying kubernetes applications.

## REFERENCES

Infrastructure
- EKS Module https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
- Autoscaling / Cost Optimization: https://docs.aws.amazon.com/eks/latest/best-practices/cas.html
- IAM Service Roles https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master 