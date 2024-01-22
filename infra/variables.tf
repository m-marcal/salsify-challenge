variable "aws_region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The project name to be used as a prefix for resources"
  type        = string
  default     = "salsify"
}

# Applications specific vars
variable "database_url" {
  description = "Postgres database url in the format: postgres://user:pass@ip_addr:port/gifmachine"
  type        = string
}

variable "rack_env" {
  description = "Gifmachine app run-mode (development | *production)"
  type        = string
  default     = "production"
}

variable "gifmachine_password" {
  description = "To be discussed"
  type        = string
  default     = ""
}

