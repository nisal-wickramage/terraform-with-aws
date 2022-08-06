terraform {

    backend "s3" {
        bucket = "${var.environment}-${var.project_name}-tfstate"
        key = "${var.environment}-${var.project_name}.tfstate"
        region = "${var.region}"
        dynamodb_table = "${var.environment}-${var.project_name}-tfstatelock"
    }

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
  region  = "${var.region}"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.environment}-${var.project_name}-${var.s3_bucket_name}"
  region = "${var.region}"

  tags = {
    provisioning_method = "terraform",
    environment = var.environment
  }
}

resource "aws_dynamodb_table" "ddb_table" {
  name           = "${var.environment}-${var.project_name}-${var.ddb_table_name}"
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
    provisioning_method = "terraform",
    environment = var.environment
  }
}
