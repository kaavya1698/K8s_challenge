terraform {
  required_version = "~> 0.12.20"
}
## Creating AWS region ##
provider "aws" {
  region  = "us-east-1"
}