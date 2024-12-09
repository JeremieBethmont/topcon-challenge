# MONITORING

This implements two different examples of a basic monitoring email notifications using Cloudwatch metrics and Autoscaling Groups notifications.

## Example 1: Cloudwatch Alarm

One cloudwatch alarm will be deployed for each autoscaling groups for the EKS clusters in scope.

The alarms will get triggered when a EC2 metric `StatusCheckFailed` for the given autoscaling groups.

The cloudwatch alarm is integrated to an SNS topic that sends notifications by email.

## Example 2: Autoscaling Notification

All autoscaling groups in scope of EKS node groups will be assigned a notification configuration.

The notification configuration emits an message on an SNS topic when either and underlying EC2 instance is in "Launch Error" or "Terminate Error".

The SNS topic will send an email to the operator as this requires manual intervention.


## Deployment Instructions

Steps to deploy monitoring with Terraform.

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

4. Approve the email subsciption request received in your inbox.