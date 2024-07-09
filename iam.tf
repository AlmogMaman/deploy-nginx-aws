# # Define an IAM policy that allows describing EC2 AMIs
# resource "aws_iam_policy" "ec2_full_permission" {
#   name        = "full-ec2-permissions"
#   description = "Policy grants full ec2 permission"

#   # Policy document
#   policy = <<EOT
#     {
#       "Version": "2012-10-17",
#       "Statement": [
#           {
#               "Effect": "Allow",
#               "Action": [
#                   "ec2:*"
#               ],
#               "Resource": "*"
#           }
#       ]
#     }
#     EOT
# }


# resource "aws_iam_user" "aws_user" {
#   name = var.aws_user_name
# }


# resource "aws_iam_user_policy_attachment" "attach_policy" {
#   user       = aws_iam_user.aws_user.name
#   policy_arn = aws_iam_policy.ec2_full_permission.arn
# }
