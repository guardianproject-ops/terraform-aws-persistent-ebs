output "iam_policy" {
  value = aws_iam_policy.attach_ebs
}

output "ebs_volume" {
  value = aws_ebs_volume.main
}
