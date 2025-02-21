output "secrets" {
  description = "Map of secret names to their ARNs in AWS Secrets Manager"
  value       = { for k, v in aws_secretsmanager_secret.app_secrets : k => v.arn }
  sensitive   = true  # Best practice: Mark as sensitive since these are secret ARNs
}

output "ssm_parameters" {
  description = "Map of SSM parameter names containing secret ARNs. Format: /<environment>/<service_name>/secrets/<secret_name>"
  value       = { for k, v in aws_ssm_parameter.secret_arns : k => v.name }
  sensitive   = true  # Best practice: Mark as sensitive since these reference secrets
}