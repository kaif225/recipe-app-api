resource "aws_iam_user" "cd" {
  name = "recipe-app-api-cd"
}

resource "aws_iam_access_key" "cdd" {
  user = aws_iam_user.cd.name
}

// Policy for terraform backend to s3 and Dynamodb access
data "aws_iam_policy_document" "tf_backend" {
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.tf_state_file}"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["arc:aws:s3:::${var.tf_state_file}/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = ["arn:aws:dynamodb:*:*:table/${var.tf_state_locking_table}"]
  }
}

resource "aws_iam_policy" "tf_backend_policy" {
  name   = "${aws_iam_user.cd.name}-tf-s3-dynamodb"
  policy = data.aws_iam_policy_document.tf_backend.json
}

resource "aws_iam_user_policy_attachment" "tf_backend_policy_attach" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.tf_backend_policy.arn
}

