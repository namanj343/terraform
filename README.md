# terraform
This repo consist of terraform infrastructure files that helps in creating infra.
With the every creating of file use the following commands to create and apply changes to the infrastructure:
1) terraform init: To start terraform infra creation
2) terraform plan
3) terraform apply

-------------------------
Take help from the bellow videos to create infra using terraform files:
# https://www.youtube.com/playlist?list=PL_OdF9Z6GmVaRD6e6sYLQO_WYqTKcj3aj
1) TO apply role and policy to ec2 instance please reffer the bellow link:
# https://medium.com/@devopslearning/aws-iam-ec2-instance-role-using-terraform-fa2b21488536
In our file i have apply the s3 role to ec2 instance to access s3 bucket
2) To apply role s3 buckets use: 
# https://www.terraform.io/docs/providers/aws/r/s3_bucket_policy.html
3) To create rds Database: 
# https://www.terraform.io/docs/providers/aws/r/db_instance.html
4) To setup vpc and subnets refers:
for subnets
# https://www.terraform.io/docs/providers/aws/r/subnet.html
5)For security groups:
# https://www.terraform.io/docs/providers/aws/r/security_group.html
