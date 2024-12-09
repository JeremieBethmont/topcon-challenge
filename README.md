# Topcon - Devops Technical Test

- [Topcon - Devops Technical Test](#topcon---devops-technical-test)
  - [Challenge](#challenge)
    - [IaC test](#iac-test)
      - [Instruction #1](#instruction-1)
      - [Instruction #2](#instruction-2)
      - [Instruction #4](#instruction-4)
    - [CI/CD test](#cicd-test)
      - [Instruction #1](#instruction-1-1)
      - [Instruction #2](#instruction-2-1)
      - [Instruction #2](#instruction-2-2)

## Challenge

### IaC test

For simplicity, all the code has been divided accross folders and hosted on a single repository. However in a real production situation they should be hosted accross dedicated repositories.

#### Instruction #1

> Provide infrastructure as code to deploy WordPress using containers (any container
orchestrator) on a cloud provider of your choice (AWS and Terraform are preferred).

**Solution** 

Follow instructions in `README` files for each section in this order:
1. Deploy Infra: [infra](./infra/README.md)
2. Build Wordpress: [app](./app/README.md)
3. Deploy helm charts: [helm](./helm/README.md)

**Comments**

In the context of the challenge, the helm charts are being deployed using Terraform `helm_release` resource. While this is convenient for testing it is not a strategy I would recomend for production environment. I would suggest implementing a GitOps approach using `ArgoCD` or `Flux`.

#### Instruction #2

> The service should be able to autoscale.

**Solution**

Wordpress Deployment: The wordpress service is deployed as part of a K8s "deployment" which is configured with autoscaling parameters. See values [here](./helm/templates/wordpress-values.yaml).

Cluster-autoscaler: the underlying infrastructure would scale out using the `cluster-autoscaler` service if nodes become unschedulable. See values [here](./helm/templates/cluster-autoscaler-values.yaml).

**Instruction #3**

> The infrastructure should notify by email if there is any issue.

**Solution**

Follow instructions in `README` files for deploying monitoring:
1. Deploy monitoring: [monitoring](./monitoring/README.md)

The solution leverages two type of alarm that will send an email on trigger: "clouwatch alarm" and "autoscaling notifications". See [README](./monitoring/README.md) for more details.

Note that a better monitoring solution should be deployed for monitoring Kubenertes infrastracture. Prometheus or Datadog for example. These monitoring solutions would allow for more complex monitoring scenarios and better integration with notification solutions (e.g Pagerduty, Slack,...). 

#### Instruction #4

> We are looking to optimize infrastructure costs for a variable load, minimizing fixed costs
Provide the code for the solution.

**Solution**

NOTE: AWS released recently [EKS Auto Mode](https://docs.aws.amazon.com/eks/latest/userguide/automode.html) which fully automates the scaling operations of the underlying infrastructure. However, for this specific challenge a more traditional approach has been used by deploying `cluster-autoscaler` service.

The `cluster-autoscaler` service deployed will scale the cluster in and out based on the workload and within range of the EKS Node Group scaling configuration. See the deployment code [here](./helm/helm.tf) and the source documentation [here](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler).

More complex scaling options could also be implemented using [Vertical Pod Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler): to adjust pods resource requets based on usage.

Also, in order to minize fixed costs, a small node group could be deployed for handling regular load in parallel of another node group that would leverage AWS spots instances for spikes of load. This comes with a few technical challenges.

### CI/CD test

#### Instruction #1

> Write a brief textual answer on the following questions (around one page) and attach a diagram
for a model CI/CD pipepline.
> - How do you setup an end-to-end pipeline from dev to deployment for this scenario? (long
answer)
> - How could code quality and security fit into the ci/cd pipeline?

**Solution**


**Step 1: Local Dev and Test**

The Developer writes code locally with the associated tests.

Following a "fail fast" approach, the tests should be run as early as possible on the local machine leveraging containers technology like docker. That way the developers have a quick feedback loop and can iterate.

If the code requires complex dependencies to be tested locally, a local kubernetes deployment such as `minikube` could be used to replicate the cloud deployment.

**Step 2: Code commit**

The code is commited to Github as part of a Pull Request.

On pull request creation, a CI workflow is triggered and runs basic tests (e.g unit tests), code quality scans, code security scan, container builds tests.

The PR will only be allowed to be raised (open) if the pipeline executed successfully. Otherwise, the developper will need to commit fixes in order to raise the PR.

**Step 3: PR Review and Merge**

The code is reviewed by peers via a Pull Request. It is then approved or rejected with relevant comments.

If approved, the developer is allowed to merge its PR and a new CI workflow will be triggered. The same basic set of tests will be ran then the containers will be built and published to a container registry. As well as a new tag version for the container image will be published.

Using AWS ECR, a scan of the container image will be performed to detect vulnerability.

**Step 4: Deployment and promotion throughout the environments.**

The CD code for each environment will be updated in order to deploy and promote the new image throughout the environments. Using a Gitops approach a tool like `ArgoCD` would read the deployment declaration for each env and apply it. Which means that when updating the image tag version of a given container it will be automtically replaced following the defined rollout and rollback strategy.

The testing practices varies largely depending on each organisation.
- The DEV environment is usually used to manually test and freely break any applications. Developers are generally be given access if they cannot reproduce the dev environment locally.
- The STANGING environment is used for running in depth testing (QA, Security, Load testing). It should reflect the "future" stable version of production. No code should be promoted to prod without the entire application ecosystem succeeding at passing staging tests. Sometimes it is an environment also open to a few public users for beta testing or bug bounty access.
- The PROD environment is where the latest stable version of the applications are released and accessible to the public.


#### Instruction #2

> Comment on which tools would you recommend, CI/CD tools, steps of the CI/CD cycle

**Solution**

The solution design above makes use of the following tools:
- Containers: docker - most commonly used containerization techonology used from development all the way to production.
- Local Kubernetes: minikube - allows the replication of a K8s environment locally. Ideal for a local dev environment.
- CI: Github Actions - fully integrated with github repository with many plugins and integrations available. Allows for a quick feedback loop to developpers.
- IaC/Infra deployment (not described): Terraform - most commonly used IaC tools for managing infra deployment, especially for cloud environment.
- Code security scanning (directly in Github)
  - Sonarcloud - scans the code for vulnerability and quality (note: can be used as VScode plugin even)
  - Github dependabot - scans for libraries/dependecies update
- Container Vulnerability
  - AWS ECR Vulnerability Scanner - to identify software vulnerabilities in your container images. 
  - Snyk: For live container scanning in kubernetes cluster.
- CD: ArgoCD - manages kubernetes deploymnents following a Gitops approach.

#### Instruction #2

> Provide a configuration file of this pipeline in the CI/CD system of your choice (Jenkins,
Gitlab, Github, etc.).

**Solution**

Quick EXAMPLE of small CI code for Wordpress using Github Action: [](.github/workflows/wordpress-dev.yml).

This does not include any security or code quality testing for lack of time and lack of knowledge around wordpress development.
