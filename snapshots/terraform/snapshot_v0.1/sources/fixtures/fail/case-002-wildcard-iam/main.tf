resource "aws_iam_policy" "wildcard" {
  name   = "pa-fixtures-wildcard"
  policy = <<EOF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF_POLICY
}
