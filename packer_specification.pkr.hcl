source "yandex" "ubuntu-nginx" {
  token               = "${var.token}"
  folder_id           = "${var.folder_id}"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "ubuntu"
  use_ipv4_nat        = "true"
  image_description   = "${var.image_description}"
  image_family        = "ubuntu-2004-lts"
  image_name          = "my-ubuntu-nginx"
  subnet_id           = "${var.subnet_id}"
  disk_type           = "network-ssd"
  zone                = "ru-central1-a"
}

# this is declaring variables section

variable "token" {
type = string
default = ""
#to prevent from leaking sensitive data
sensitive = true
}

variable "folder_id" {
type = string
default = ""
}

variable "image_description" {
type = string
default = ""
}

variable "subnet_id" {
type = string
default = ""
}

 
build {
  sources = ["source.yandex.ubuntu-nginx"]

# this commands will obviously install nginx

  provisioner "shell" {
    inline = ["sudo apt-get update -y",
              "sudo apt-get install -y nginx",
              "sudo systemctl enable nginx.service"]
  }
}
