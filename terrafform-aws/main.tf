terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}


resource "aws_iam_role" "ec2_role" {
  name = "ec2-s3-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "s3_access" {
  name = "s3-access"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"],
      Resource = [
        aws_s3_bucket.storage.arn,
        "${aws_s3_bucket.storage.arn}/*"
      ]
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-profile"
  role = aws_iam_role.ec2_role.name
}


resource "aws_instance" "app" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.firewall.id]

  tags = {
    Name = "app"
  }
}

resource "aws_s3_bucket" "storage" {
  bucket = "storage-bucket-terraform"
}

# resource "aws_s3_bucket_ownership_controls" "ownership" {
#   bucket = aws_s3_bucket.storage.id
#
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }
#
# resource "aws_s3_bucket_public_access_block" "access_block" {
#   bucket = aws_s3_bucket.storage.id
#   block_public_acls = true
#   block_public_policy = true
#   ignore_public_acls = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_policy" "bucket_policy" {
#   bucket = aws_s3_bucket.storage.id
#
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Principal = {
#         AWS = aws_iam_role.ec2_role.arn
#       },
#       Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"],
#       Resource = [
#         aws_s3_bucket.storage.arn,
#         "${aws_s3_bucket.storage.arn}/*"
#       ]
#     }]
#   })
# }

resource "aws_vpc" "main" {
  cidr_block = ["10.0.0.0/16"]
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = ["10.0.1.0/24"]
  availability_zone = "us-east-1a"
}

resource "aws_security_group" "firewall" {
  name = "firewall"
  description = "Firewall security group"

  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}