provider "aws" {
 region = "ap-south-1"
 access_key = "AKIA23SPDBCQIT4JEBAH"
 secret_key =  "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"
}

resource "aws_vpc" "MyVPC" {
 cidr_blocks = "10.0.0.0/16"
 instance_tenancy = "dedicated"
 
 tags  {
   Name = "MyterraformVPC"
 }
}

resource "aws_subnet" "subnets" {
 vpc_id = "${aws_vpc.MyVPC.id}"
 cidr_block = "10.0.1.0/20"
 tags = {
 Name = "subnet1"
 }
}

