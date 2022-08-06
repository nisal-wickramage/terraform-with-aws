https://639820099571.signin.aws.amazon.com/console

1. Add `main.tf` with terraform settings, provider  and 2 resources to create an S3 bucket and DDB table
2. Move resource names to variables, move values to tfvar. `terraform apply -var-file=values.tfvars`
3. Move state to S3. (S3 bucket should have bucket policy to avoid deletion)

Key decisions
backend stored in s3 to enable collaboration amongst a team.


New plan

create user script 
create tf state bucket and ddb table
create tf for single environment
go multi env
address duplication issues with terragrunt

## create tf state bucket and ddb table

run initialize.sh shell script





