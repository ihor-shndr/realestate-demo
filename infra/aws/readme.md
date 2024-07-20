# Prerequisites:
1. `GitHub CLI` - [link](https://cli.github.com/)
2. `AWS CLI` - [link](https://aws.amazon.com/cli/)

### Configure GitHub CLI:
`gh auth login`

### Configure AWS CLI:
1. Got to `IAM` service in AWS Console: [link](https://us-east-1.console.aws.amazon.com/iam/home#/users)
2. Click `Create user`
3. Type name and click `Next`
4. Select `Attach policies directly`, in `Permission policies` tick `AdministratorAccess`, then click `Next`
5. Create user
6. Open newly created user
7. Go to `Security credentials` tab
8. Click `Create access key`
9. Select `Command Line Interface` as `Use case`
10. Create a secret and store it somewhere
11. In terminal run `aws configure`
12. Type key and secret


## Set up AWS credentials and create cloud storage for Terraform:
run `set-up.sh` from `scripts` folder with `app name` as a first parameter. Ex: `./set-up.sh myapp`. It will prepare Terraform and GitHub repository for the first usage.


## Add a new environment:
create a new workflow in `.github/workflows` folder and specify a branch name

## Clean up everything:
run `clean-up.sh` from `scripts` folder with `app name` as a first parameter and a list of environments. Ex: `./set-up.sh myapp prod env`. It will delete all the infrastructurem the terraform underlying storage and IAM user in AWS