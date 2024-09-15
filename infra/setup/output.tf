output "cd_user_access_key_id" {
  value = aws_iam_access_key.cdd.id
}

output "cd_user_access_key_secret" {
  value = aws_iam_access_key.cdd.secret
  sensitive = true
}

