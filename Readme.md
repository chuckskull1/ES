# ES-Terraform
This repo contains terraform script for installing elasticsearch using open distro.



## Prerequisite
- You need to have an [AWS account](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3Fstate%3DhashArgs%2523%26isauthcode%3Dtrue&client_id=arn%3Aaws%3Aiam%3A%3A015428540659%3Auser%2Fhomepage&forceMobileApp=0&code_challenge=gjVJoawn3_fcc7rrNxkhtTCQoJJdCpOB9cNxhXTxpM4&code_challenge_method=SHA-256).
- You need to have aws cli installed along with aws file configiured (access and secret key). If not, you can follow [this](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html).
- You need to have terraform installed. If not, you can download it from [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).
> Note: AWS is the assumed cloud provider


## How to use

To initialise terraform working directory containing terraform configuration files use following command:

```sh
terraform init
```
Add the actual values to ```values.tfvars``` file.

To see what resources will be created by the terraform script use following command:

```sh
terraform plan -var-file="values.tfvars"
```
To apply changes required to reach the desired state of the configuration use following command:
```sh
terraform apply -var-file="values.tfvars"
```

> Note: You can use `terraform destroy` command incase you need to destroy the infrastructure you created with the given script.

---
# Instructions for evaluation
In this solution I have used open distro for installing elasticsearch as it was best suited for the solution as it contains good security features. I have used terraform script for the automation. In which I have used services like EC2 INSTANCE, IAM and S3. I tried using aws free tier instance but it had some memory issue so had to go with t2.medium instance size.

I have used a config.yml file for elasticsearch configuration which is stored in s3(sample can be seen in the root directory with the file name config.yml) which is copied to EC2 instance that gets up, replacing the values at runtime and then start the ES service. 

For securing elasticsearch I have used credentials and it runs on TLS for encrypted communication.

Instance can be monitored using cloudwatch logs on matrices like memory.

