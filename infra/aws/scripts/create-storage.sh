APP_NAME=$1


S3_BUCKET_NAME="terraform-state-bucket-$APP_NAME"
DYNAMODB_TABLE_NAME="terraform-locks-$APP_NAME"

# Create S3 bucket
aws s3api create-bucket --bucket $S3_BUCKET_NAME
aws s3api put-bucket-versioning --bucket $S3_BUCKET_NAME --versioning-configuration Status=Enabled

# Create DynamoDB table
aws dynamodb create-table \
    --table-name $DYNAMODB_TABLE_NAME \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST


