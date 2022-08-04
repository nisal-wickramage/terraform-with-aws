PREFIX="sh"
while getopts e:b:t: flag
do
    case "${flag}" in
        e) environment=${OPTARG};;
        b) bucket_name=${OPTARG};;
        t) table_name=${OPTARG};;
    esac
done

if [ -z "$environment" ]; then
    raise error "Environment parameter is required."
fi

if [ -z "$bucket_name" ]; then
    raise error "Bucket name parameter is required."
fi

if [ -z "$table_name" ]; then
    raise error "Table name parameter is required."
fi

# echo "$PREFIX-$environment-$bucket_name"
# echo "$PREFIX-$environment-$table_name"
aws s3api create-bucket --bucket "$PREFIX-$environment-$bucket_name" --region us-east-1
aws dynamodb create-table --table-name "$PREFIX-$environment-$table_name" --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST --tags Key=env,Value=dev