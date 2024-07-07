#Pay attention to take care of the AWS CLI configuration.
#Pay attention that the acceess and secret keys are as env variables for security reasons.
#Another option is to configure the ASW CLI seperatly. But I preffer this solution
#Becasue it can be fit to the gitHub action deployment in the future. 
provider "aws" {
  region  = var.region
  access_key = "${AWS_MOVEO_USER_ACCESS_KEY}"
  secret_key = "${AWS_MOVEO_USER_ACCESS_KEY}"
}
