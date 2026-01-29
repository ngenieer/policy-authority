resource "aws_security_group_rule" "public_ingress" {
  type        = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}
