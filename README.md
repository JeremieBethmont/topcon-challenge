# Topcon - Devops Technical Test

## Challenge

### IaC test

**Instruction #1**

> Provide infrastructure as code to deploy WordPress using containers (any container
orchestrator) on a cloud provider of your choice (AWS and Terraform are preferred).

**Solution** 

Follow instructions in `README` files for each section in this order:
1. Deploy Infra: [infra](./infra/README.md)
2. Deploy Monitoring: [monitoring](./monitoring/README.md)
3. Build Wordpress: [app](./app/README.md)
4. Deploy helm charts: [helm](./helm/README.md)

**Comments**

While I do not recommend using `Terraform` for deploying helm charts it has been used in this case for illustrating a deployment as per instructions. In production a more appropriate tool such as `ArgoCD` should be used.

For simplicity, all the code has been divided accross folders and hosted on a single repository. However in a real production situation they should be hosted accross dedicated repositories for each environment e.g infra-dev, helm-dev, app-<name>-dev.

**Instruction #2**

> The service should be able to autoscale.

**Solution**

The wordpress service is deployed as part of a K8s "deployment" which is configured with autoscaling parameters. See values [here](./helm/templates/cluster-autoscaler-values.yaml).

Also, the underlying would scale out using the `cluster-autoscaler` service if nodes become unschedulable.

**Instruction #3**

> The infrastructure should notify by email if there is any issue.

**Solution**

A cloudwatch alarm that watches EKS nodes for bad health check has been deployed. When in triggered state it sents an notification to an SNS topic which is subscribed to an email address.

- [Cloudwatch alarm](./infra/cloudwatch.tf)
- [SNS Topic](./infra/sns.tf)

**Instruction #4**


- We are looking to optimize infrastructure costs for a variable load, minimizing fixed costs
Provide the code for the solution.

### CI/CD test

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


