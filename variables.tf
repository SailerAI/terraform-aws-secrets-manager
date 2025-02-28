variable "service_name" {
  description = "Nome do projeto"
  type        = string
  # Best practice: Validate service name format
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.service_name))
    error_message = "Service name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Ambiente (dev, hml, prd, etc.)"
  type        = string
  # Best practice: Limit to specific environment values
  validation {
    condition     = contains(["dev", "hml", "prd"], var.environment)
    error_message = "Environment must be one of: dev, hml, prd."
  }
}

variable "secrets" {
  description = "Lista de secrets a serem criados no AWS Secrets Manager"
  type = list(object({
    name  = string # Nome do secret
    value = string # Valor do secret (pode ser um JSON stringificado)
  }))
  # Best practice: Validate secret names and ensure list isn't empty
  validation {
    condition     = length(var.secrets) > 0
    error_message = "At least one secret must be specified."
  }
  validation {
    condition     = alltrue([for s in var.secrets : can(regex("^[a-zA-Z0-9/_+=.@-]+$", s.name))])
    error_message = "Secret names must contain only alphanumeric characters and the following: /_+=.@-"
  }
}