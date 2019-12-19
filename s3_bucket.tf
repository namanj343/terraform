provider "aws" {
 region = "ap-south-1"
 access_key = "AKIA23SPDBCQIT4JEBAH"
 secret_key =  "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"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "test.terraform001"
  acl    = "private"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = "${aws_s3_bucket.bucket.id}"
  policy = <<POLICY
{ 
   "Version": "2012-10-17",
   "Id": "MYBUCKETPOLICY",
   "Statement": [
   {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
      "AWS": "*"
       },      
      "Action"  : "s3:GetObject",
      "Resource": "arn:aws:s3:::test.terraform001/*"
    }    
  ]
}
POLICY
}
