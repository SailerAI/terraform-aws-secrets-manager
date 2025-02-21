# terraform-aws-secrets-manager
Terraform module to create secrets 

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.app_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.app_secrets_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_ssm_parameter.secret_arns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Ambiente (dev, hml, prd, etc.) | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Lista de secrets a serem criados no AWS Secrets Manager | <pre>list(object({<br/>    name  = string  # Nome do secret<br/>    value = string  # Valor do secret (pode ser um JSON stringificado)<br/>  }))</pre> | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Nome do projeto | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Map of secret names to their ARNs in AWS Secrets Manager |
| <a name="output_ssm_parameters"></a> [ssm\_parameters](#output\_ssm\_parameters) | Map of SSM parameter names containing secret ARNs. Format: /<environment>/<service\_name>/secrets/<secret\_name> |
<!-- END_TF_DOCS -->