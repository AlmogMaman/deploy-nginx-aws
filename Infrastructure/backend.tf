terraform {
  backend "s3" {
    bucket         = "remote-backend-devops-project"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-locking"
    encrypt        = true
  }
}