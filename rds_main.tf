provider "aws" {
 region = "ap-south-1"
 access_key = "AKIA23SPDBCQIT4JEBAH"
 secret_key =  "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"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  max_allocated_storage = 100
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  skip_final_snapshot  = "false"
  final_snapshot_identifier = "delete123"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible     = true
  vpc_security_group_ids = [
      "sg-044ec9f23d0e47aef",
  ]
}


