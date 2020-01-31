provider "aws" {
  region = "us-east-1"
  version = "~> 1.60.0"
}

provider "template" {
  version = "~> 2.1.2"
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    encrypt = "true"
  }
}
