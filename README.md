# Topcon - Devops Technical Test

## Challenge

1. IaC test
   
- Provide infrastructure as code to deploy WordPress using containers (any container
orchestrator) on a cloud provider of your choice (AWS and Terraform are preferred).
- The service should be able to autoscale.
- The infrastructure should notify by email if there is any issue.
- We are looking to optimize infrastructure costs for a variable load, minimizing fixed costs
Provide the code for the solution.

2. CI/CD test

Write a brief textual answer on the following questions (around one page) and attach a diagram
for a model CI/CD pipepline.
- How do you setup an end-to-end pipeline from dev to deployment for this scenario? (long
answer)
- Comment on which tools would you recommend, CI/CD tools, steps of the CI/CD cycle
- How could code quality and security fit into the ci/cd pipeline?

Provide a configuration file of this pipeline in the CI/CD system of your choice (Jenkins,
Gitlab, Github, etc.).


## Preparation

- Terraform for EKS
    - https://github.com/aws-ia/terraform-aws-eks-blueprints


- Terraform for Wordpress
  - 

- Terraform Cloudwatch Alarm + Email
  - https://www.beabetterdev.com/2021/02/22/aws-cloudwatch-alarm-email/
  - https://github.com/FindAPattern/cloudwatch-alarms-terraform/tree/master
  - https://aws.amazon.com/blogs/infrastructure-and-automation/automate-monitoring-for-your-amazon-eks-cluster-using-cloudwatch-container-insights/


- Wordpress CI/CD
  - https://flywp.com/blog/7048/how-to-automate-wordpress-deployment/
  - 


## INFRASTRUCTURE

### Base Infra Deployment

Steps to deploy the base infrastructure with Terraform.

The base infrastructure is composed of:
- VPC
- EKS Cluster

1. Log into AWS Account
2. Get in the `infra` directory
```
cd infra
```
3. Init terraform
```
terraform init
```
4. Review the plan (e.g no unexpected resource destruction)
```
terraform plan -var-file=variables.tfvars
``` 
5. Deploy the base infra
```
terraform apply -var-file=variables.tfvars
```
--> The deployment will take ~15mins.
6. Configure kubectl 
```
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```

## REFERENCES

Infrastructure
- https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks
- EKS Module https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
