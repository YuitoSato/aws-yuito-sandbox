terraform {
  backend "s3" {
    bucket     = "yuito-eks-backend-state-bucket"
    region     = "ap-northeast-1"
    key        = "terraform-v0.11.13.tfstate"
    encrypt    = true
    lock_table = "yuito-eks-terraform-lock"
    kms_key_id = "1e281c03-f209-4c0b-925a-f4a3f6f29cc0"
  }
}

provider "aws" {
  region = "${lookup(var.common, "${terraform.env}.region")}"
}

# tfstate S3 bucket
resource "aws_s3_bucket" "backend-state-bucket" {
  bucket = "yuito-eks-backend-state-bucket"

  versioning {
    enabled = true
  }
}

# KMS
resource "aws_kms_key" "backend-kms-key" {
  description             = "Key for encrypting ssm prameter"
  deletion_window_in_days = 7
}

# Dynamo lock table
resource "aws_dynamodb_table" "backend-lock-table" {
  name           = "yuito-eks-terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
