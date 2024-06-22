terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">3.5.0"
    }
  }

  backend "s3" {
    region         = "us-east-1"       # Change to your bucket's region
  }
}
provider "aws" {
}
