variable "pgadmin_default_email" {
  description = "pgAdmin administrator email address"
  type        = string
  sensitive   = true
}

variable "pgadmin_default_password" {
  description = "pgAdmin administrator password"
  type        = string
  sensitive   = true
}

variable "postgresql_version" {
  description = "Version of PostgreSQL"
  type        = string
  default     = "10"
}
