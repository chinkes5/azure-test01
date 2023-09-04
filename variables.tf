variable "address_space" {
  type        = list(any)
  description = "A map representing the IP address ranges for the virtual network in an Azure infrastructure deployment"
}

variable "createdBy" {
  type        = string
  default     = "JEMC"
  description = "Who created this resource"
}

variable "environment" {
  type        = string
  description = "The environment this resource is in"
}

variable "location" {
  type        = string
  default     = "westus2"
  description = "The Azure region for a resource to be in"
}
