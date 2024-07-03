APP_NAME=$1
ENV=$2

./create-backend-conf.sh $APP_NAME $ENV #us-east-1

terraform -chdir=../terraform init  -backend-config=backend.conf

terraform -chdir=../terraform destroy -auto-approve -var env=$ENV -var app_name=$APP_NAME

aws s3api delete-objects \
      --bucket terraform-state-bucket-$APP_NAME \
      --delete "$(aws s3api list-object-versions \
      --bucket terraform-state-bucket-$APP_NAME | \
      jq '{Objects: [.Versions[] | {Key:.Key, VersionId : .VersionId}], Quiet: false}')"

aws dynamodb delete-table --table-name terraform-locks-$APP_NAME