## Prerequisites:
1. `GitHub CLI`
2. `Azure CLI`

## Authorize CLIs:
1. Azure: `az login`
2. GitHub: `gh auth login`


## Set up Azure credentials and create cloud storage for Terraform:
run `set-up.sh` from `scripts` folder with `app name` as a first parameter. Ex: `./set-up.sh myapp`. It will prepare Terraform and GitHub repository for the first usage.


## Add a new environment:
create a new workflow in `.github/workflows` folder and specify a branch name