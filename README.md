1. Add `main.tf` with terraform settings, provider  and 2 resources to create an S3 bucket and DDB table
2. Move resource names to variables, move values to tfvar. `terraform apply -var-file=values.tfvars`
3. Move state to S3. (S3 bucket should have bucket policy to avoid deletion)
