variable "rgroup-name" {
  default = "9923-rg"
  description = "Resource group name"
  type        = string
}

variable "rgroup-location" {
  default = "canadacentral"
  description = "Resource group location"
  type        = string
}

variable "network-space" {
  default     = ["10.0.0.0/16"]
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet-address-space" {
  default     = ["10.0.0.0/24"]
  description = "Address space for the subnet"
  type        = list(string)
}
