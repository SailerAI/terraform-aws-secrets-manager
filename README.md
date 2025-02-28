# terraform-aws-secrets-manager
Terraform module to create secrets 

<!-- BEGIN_TF_DOCS -->


## Example

```hcl
module "backend_secrets" {
  source       = "github.com/SailerAI/terraform-aws-secrets-manager"
  region       = "us-east-1"
  environment  = "dev"
  service_name = "backend"

  secrets = [
    {
      name  = "SECRET__CLIENT_ID"
      value = "XXXXYYYXYYXYXYX"
    },
   {
      name  = "SECRET__CLIENT_ID_2"
      value = "XXXXYYYXYYXYXYXZZZZZZZ"
    },
    {
      name  = "SECRET_ENCRYPT_KEY_1"
      value = "WJHIHisodagjofsadgofsdjhpa="
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Ambiente (dev, hml, prd, etc.) | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Lista de secrets a serem criados no AWS Secrets Manager | <pre>list(object({<br/>    name  = string # Nome do secret<br/>    value = string # Valor do secret (pode ser um JSON stringificado)<br/>  }))</pre> | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Nome do projeto | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Map of secret names to their ARNs in AWS Secrets Manager |
| <a name="output_ssm_parameters"></a> [ssm\_parameters](#output\_ssm\_parameters) | Map of SSM parameter names containing secret ARNs. Format: /<environment>/<service\_name>/secrets/<secret\_name> |  
<!-- END_TF_DOCS -->