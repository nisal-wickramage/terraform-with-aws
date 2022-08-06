while getopts b:t:r: flag
do
    case "${flag}" in
        b) bucket_name=${OPTARG};;
        t) table_name=${OPTARG};;
        r) region=${OPTARG};;
    esac
done

if [ -z "$bucket_name" ]; then
    raise error "Bucket name parameter is required."
fi

if [ -z "$table_name" ]; then
    raise error "Table name parameter is required."
fi

if [ -z "$region" ]; then
    raise error "Region parameter is required."
fi

# echo "$PREFIX-$environment-$bucket_name"
# echo "$PREFIX-$environment-$table_name"
aws s3api create-bucket --bucket "$bucket_name" --region "$region"
aws dynamodb create-table --table-name "$table_name" --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST --tags Key=env,Value=dev