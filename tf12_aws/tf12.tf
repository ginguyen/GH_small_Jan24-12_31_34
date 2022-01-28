terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "public_read" {
  bucket = "my-tf-log-bucket"
  acl    = "public-read"
  tags = {
    yor_trace = "650245a4-93bb-498b-ba5b-8a262c092603"
  }
}
resource "aws_s3_bucket" "public_read_write" {
  acl = "public-read-write"

  bucket = "foo_name"
  versioning {
    enabled = false
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
  tags = {
    yor_trace = "1ef318fa-56ed-4f9a-be83-99fc71d71cb9"
  }
}

resource "aws_security_group" "allow_tcp" {
  name        = "allow_tcp"
  description = "Allow TCP inbound traffic"
  vpc_id      = aws_vpc.foo_vpc.id
  ingress {
    description = "TCP from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  egress {
    from_port = 69
    to_port   = 69
    protocol  = "udp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  tags = {
    yor_trace = "93c1aaec-0cf1-4535-9568-f2eff5d57258"
  }
}