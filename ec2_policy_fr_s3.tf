
provider "aws" {
 region = "ap-south-1"
 access_key = "AKIA23SPDBCQIT4JEBAH"
 secret_key =  "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"
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["default"]
   }
}

data "aws_security_group" "sg" {
 filter {
   name = "group-name"
   values = ["secgrp"]
 }
}
resource "aws_security_group" "default" {
  name = "terraform" 
  vpc_id = "${data.aws_vpc.selected.id}"
}
resource "aws_security_group_rule" "allow_all" {
  type = "ingress"
  from_port = 80 
  to_port   = 80
  protocol  = "tcp"
#  cidr_block = ["0.0.0.0/0"]
  source_security_group_id = "${data.aws_security_group.sg.id}"
  security_group_id = "${aws_security_group.default.id}"
  
}
resource "aws_instance" "terraform" {
 ami =  "ami-0123b531fc646552f"
 instance_type = "t2.micro"
 tags = {
         Name = "terraform-web"
  }
 user_data = <<-EOF
             #! /bin/bash
             git init 
             apt-get install apache2 -y
             echo "testing the terraform application" > /var/www/html/index.html
             apt-get update && apt-get upgrade
             systemctl apache2 start
             EOF
 
 
 vpc_security_group_ids = [
      "sg-044ec9f23d0e47aef",
  ] 
 key_name = "NewAccount" 
 root_block_device {
           delete_on_termination = false
            iops                  = 100
            volume_size           = 50
            volume_type           = "gp2"
  }
 iam_instance_profile = "${aws_iam_instance_profile.test_policy_profile.name}" 
# above line is for providing role to ec2 instance
} 
--------------------------------------------------
# https://medium.com/@devopslearning/aws-iam-ec2-instance-role-using-terraform-fa2b21488536
# Creating an IAM role for ec2 as assume roles with allows us to create policy for ec2 i.e help in creating a "Trust Relationship"
resource "aws_iam_role" "ec2-role" {
  name = "ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
# Create an ec2 profile
resource "aws_iam_instance_profile" "test_policy_profile" {
  name = "test_iam_role"
  role = "${aws_iam_role.ec2-role.name}"
}
# creating an inline policy for ec2 instance
resource "aws_iam_role_policy" "ec2_s3_policy" {
  name = "ec2_s3_policy"
  role = "${aws_iam_role.ec2-role.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::spinnekar",
                "arn:aws:s3:::spinnekar/*"
            ]
        }
    ]
}
EOF
}



