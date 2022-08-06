resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.project_name}-${var.environment}-${var.s3_bucket_name}"

  tags = {
    provisioning_method = "terraform",
    environment = var.environment
  }
}

resource "aws_dynamodb_table" "ddb_table" {
  name           = "${var.project_name}-${var.environment}-${var.ddb_table_name}"
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
