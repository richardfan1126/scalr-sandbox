terraform {
  backend "remote" {
    hostname     = "richardfan1126.scalr.io"
    organization = "env-v0o2ulslskekb9s3l"

    workspaces {
      prefix = "sandbox"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  publish = true

  function_name = "scalr-lambda-simple"
  handler       = "index.lambda_handler"
  runtime       = "python3.12"

  source_path = [
    "${path.module}/../python/src"
  ]
}
