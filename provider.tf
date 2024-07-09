#Pay attention that the acceess and secret keys are as env variables for security reasons.
#Another option is to configure the ASW CLI seperatly. But I preffer this solution
#Becasue it can be fit to the gitHub action deployment in the future. without downloading the AWS CLI (faster deploymet)
provider "aws" {
  region  = var.region
  access_key = var.AWS_USER_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS_KEY
}
