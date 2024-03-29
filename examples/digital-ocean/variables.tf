variable "deployment_name" {
  type        = string
  description = "Name of the deployment of this instance"
  default     = "default"
}

variable "region" {
  type        = string
  description = "Name of the DigitalOcean region we are creating the VPC in"
  default     = "ams3"
}

variable "pg_version" {
  type        = string
  description = "Postgres version of managed DB"
  default     = "11"
}

variable "db_size" {
  type        = string
  description = "Instance size for PostgreSQL db."
  default     = "db-s-1-vcpu-1gb"
}

variable "db_user" {
  type        = string
  description = "Username to connect to DB"
  default     = "postgres"
}
