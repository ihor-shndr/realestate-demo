# Define variables
app_name=$1
IAM_USER_NAME="github-actions-user-$app_name"

# Create IAM user
aws iam create-user --user-name $IAM_USER_NAME

# Attach policies to the user
aws iam attach-user-policy --user-name $IAM_USER_NAME --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
aws iam attach-user-policy --user-name $IAM_USER_NAME --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess
aws iam attach-user-policy --user-name $IAM_USER_NAME --policy-arn arn:aws:iam::aws:policy/AdministratorAccess-AWSElasticBeanstalk
aws iam attach-user-policy --user-name $IAM_USER_NAME --policy-arn arn:aws:iam::aws:policy/IAMFullAccess

# Create access keys for the user
aws iam create-access-key --user-name $IAM_USER_NAME > iam_credentials.json

# Extract Access Key ID and Secret Access Key
AWS_ACCESS_KEY_ID=$(jq -r '.AccessKey.AccessKeyId' iam_credentials.json)
AWS_SECRET_ACCESS_KEY=$(jq -r '.AccessKey.SecretAccessKey' iam_credentials.json)

# Clean up the credentials file
rm iam_credentials.json

# Output the credentials
echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
echo "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"

gh secret set AWS_ACCESS_KEY_ID -a actions -b "$AWS_ACCESS_KEY_ID"
gh secret set AWS_SECRET_ACCESS_KEY -a actions -b "$AWS_SECRET_ACCESS_KEY"
