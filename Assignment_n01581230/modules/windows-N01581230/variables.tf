variable "windows_name" {

}

variable "subnet_id" {

}

variable "rgroup-name" {

}

variable "rgroup-location" {

}

variable "win_nb_count" {

}

variable "win_avail_set" { 
  default = "windows_avs" 
}

variable "win-vm-os-disk-attr" {
  type = map(string)
  default = {
    los-storage-account-type = "StandardSSD_LRS"
    los-disk-size            = "128"
    los-disk-Caching         = "ReadWrite"
  }
}

variable "win_vm_source_image_info" {
  type = map(string)
  default = {
    los-publisher = "MicrosoftWindowsServer"
    los-offer     = "WindowsServer"
    los-sku       = "2016-Datacenter"
    los-version   = "latest"
  }
}

variable "admin_username" {
  default = "N01581230"
}

variable "admin_password" {
  default = "Admin@123"
}

variable "storage_act" {

}