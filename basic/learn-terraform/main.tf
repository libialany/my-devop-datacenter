terraform {
  required_providers {
    awas = {
      source = "hashicornp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
