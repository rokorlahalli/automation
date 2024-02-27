terraform {
  required_version = ">= 0.12.9"
}

provider "aws" {
  version = ">= 3.3.0"
  region  = "us-west-2"
}

provider "template" {
  version = "~> 2.1"
}



