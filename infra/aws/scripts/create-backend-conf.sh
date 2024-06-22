APP_NAME=$1
ENV=$2

BUCKET=terraform-state-bucket-$APP_NAME
TABLE=terraform-locks-$APP_NAME
KEY="${APP_NAME}.${ENV}"


target_directory="../terraform/backend.conf"


echo "bucket       = \"$BUCKET\"" >> "$target_directory"
echo "dynamodb_table       = \"$TABLE\"" >> "$target_directory"
echo "key       = \"$KEY\"" >> "$target_directory"

echo "backend.conf file has been created successfully."