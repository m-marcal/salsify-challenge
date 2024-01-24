terraform {
  backend "s3" {
    bucket = "salsify-devops-challenge-poc-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}