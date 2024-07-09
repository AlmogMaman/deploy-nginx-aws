#Pay attention that the acceess and secret keys are as env variables for security reasons.
#Another option is to configure the ASW CLI seperatly. But I preffer this solution
#Becasue it make the gitHub action deployment a litle bit faster. no need to download the AWS CLI (faster deployment).
provider "aws" {
  region  = var.region
  access_key = var.AWS_USER_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS_KEY
}
