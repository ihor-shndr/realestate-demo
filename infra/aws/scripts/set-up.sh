app_name=$1
region=$2
## check that app name is not empty
if [ -z "$app_name" ]; then
  echo "Error: Please provide app name."
  exit 1
fi

## store app name in GitHub
gh variable set APP_NAME --body "$app_name"


## create AWS credentials
./create-aws-credentials.sh $app_name $region #us-east-1


## create storage for Terraform
./create-storage.sh $app_name $region #us-east-1
