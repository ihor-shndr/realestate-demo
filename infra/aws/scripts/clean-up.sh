APP_NAME=$1
ENV=$2

./create-backend-conf.sh $APP_NAME $ENV

terraform -chdir=../terraform init  -backend-config=backend.conf

terraform -chdir=../terraform destroy -auto-approve -var env=$ENV -var app_name=$APP_NAME

aws s3api delete-objects \
      --bucket terraform-state-bucket-$APP_NAME \
      --delete "$(aws s3api list-object-versions \
      --bucket terraform-state-bucket-$APP_NAME | \
      jq '{Objects: [.Versions[] | {Key:.Key, VersionId : .VersionId}], Quiet: false}')"

aws s3api delete-bucket --bucket terraform-state-bucket-$APP_NAME

aws dynamodb delete-table --table-name terraform-locks-$APP_NAME

#Delete user
USER_NAME="github-actions-user-$APP_NAME"
POLICIES=$(aws iam list-attached-user-policies --user-name $USER_NAME --query "AttachedPolicies[*].PolicyArn" --output text)

for POLICY_ARN in $POLICIES
do
  aws iam detach-user-policy --user-name $USER_NAME --policy-arn $POLICY_ARN
done

ACCESS_KEYS=$(aws iam list-access-keys --user-name $USER_NAME --query "AccessKeyMetadata[*].AccessKeyId" --output text)

for ACCESS_KEY_ID in $ACCESS_KEYS
do
  aws iam delete-access-key --user-name $USER_NAME --access-key-id $ACCESS_KEY_ID
done

aws iam delete-user --user-name $USER_NAME