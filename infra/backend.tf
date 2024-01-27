terraform {
  backend "s3" {
    bucket = "salsify-devops-challenge-poc-terraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
