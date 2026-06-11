variable "vpc_cidr_block" {
  description = "CIDR block pentru VPC-ul creat de modul"
  type        = string
}

variable "vpc_name" {
  description = "Numele VPC-ului"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "demo"
}

variable "project" {
  description = "Project tag"
  type        = string
  default     = "terraform-state-migration"
}