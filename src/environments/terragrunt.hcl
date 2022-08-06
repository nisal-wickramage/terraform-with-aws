generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    provider "aws" {
      profile = "default"
      region  = "${local.region}"
    }
  EOF
}

generate "backend" {
  path = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    terraform {

      backend "s3" {
        bucket = "${local.project_name}-${path_relative_to_include()}-${local.backend_bucket_name}"
        key = "tfstate.tfstate"
        region = "${local.region}"
        dynamodb_table = "${local.project_name}-${path_relative_to_include()}-${local.backend_table_name}"
      }

      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 4.25"
        }
      }

      required_version = ">= 0.14.9"
    }
  EOF
}

terraform {
  source = "../..//modules"
}


locals {
  region = "us-east-1"
  project_name = "sh"
  backend_bucket_name = "tfstate"
  backend_table_name = "tfstatelock"
}

inputs = {
  environment = path_relative_to_include()
  project_name = local.project_name
  region = local.region
  s3_bucket_name = "demo"
  ddb_table_name = "demo"
}