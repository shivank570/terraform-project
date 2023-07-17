variable "prefix" {
  default = "N01581230"
}

locals {
  vm_name = "${var.prefix}-vm"
}

variable "rgroup-name" {

}

variable "rgroup-location" {

}

variable "windows_name" {

}

variable "win_virtual_machine_id" {

} 

variable "linux-vm-name" {

}

variable "linux_virtual_machine_id" {

}

variable "count_vm" {
  default="4"
}