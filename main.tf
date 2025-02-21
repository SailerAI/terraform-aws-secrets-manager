# Create AWS Secrets Manager secrets for each secret defined in var.secrets
# The secrets are created with a hierarchical naming pattern: /<service>/<environment>/<secret-name>
resource "aws_secretsmanager_secret" "app_secrets" {
  # Transform the list of secrets into a map with secret names as keys
  for_each = { for secret in var.secrets : secret.name => secret }

  name = format("/%s/%s/%s", var.service_name, var.environment, each.key)
  
  # Add tags for better resource management and resource grouping
  tags = {
    Environment = var.environment
    Service     = var.service_name
    ManagedBy   = "terraform"
  }

  # Specify recovery window to prevent accidental deletion
  # Secrets can be recovered within this time period if accidentally deleted
  recovery_window_in_days = 7
}

# Create versions for each secret with their corresponding values
resource "aws_secretsmanager_secret_version" "app_secrets_version" {
  for_each = { for secret in var.secrets : secret.name => secret }

  # Link each version to its parent secret using the secret's ID
  secret_id     = aws_secretsmanager_secret.app_secrets[each.key].id
  secret_string = each.value.value  # Set the actual secret value from var.secrets
}

# Create SSM Parameters to store the ARNs of the secrets
# This makes it easier for other resources to reference these secrets
resource "aws_ssm_parameter" "secret_arns" {
  for_each = aws_secretsmanager_secret.app_secrets

  # Create parameters with a consistent naming pattern: /<service>/<environment>/secrets/<secret-name>-arn
  name  = format("/%s/%s/secrets/%s-arn", var.service_name, var.environment, each.key)
  type  = "String"
  value = each.value.arn  # Store the ARN of the secret
  
  # Add consistent tags for resource management
  tags = {
    Environment = var.environment
    Service     = var.service_name
    ManagedBy   = "terraform"
  }
}
