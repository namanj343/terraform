
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
#  cidr_blocks = ["0.0.0.0/0"]
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
