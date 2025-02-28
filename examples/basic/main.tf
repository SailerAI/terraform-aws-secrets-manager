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