terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "serverlesshub-bucket"

  tags = {
    provisioning_method = "terraform"
  }
}

resource "aws_dynamodb_table" "ddb_table" {
  name           = "serverlesshub-ddb"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  range_key      = "datetime"

  attribute {
    name = "id"
    type = "N"
  }

  attribute {
    name = "datetime"
    type = "S"
  }

  tags = {
    provisioning_method = "terraform"
  }
}
