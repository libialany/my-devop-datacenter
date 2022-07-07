variable "ami_id" {
  type = string
  default = "ami-6f68cf0f"
}
# the way can be accessed
source_ami = "{var.ami_id}"

variable "script_path" {
  default = env("SCRIPT_PATH")
}

provisioner "shell" {
    script = "${var.script_path}/demo-script.sh"
}

# packer build -var 'app_name=httpd' ami.pkr.hcl
# packer build -var-file="vars.packet.hcl"
# packer build -var-file=variables.json ami.pkr.hcl


#MANY
locals {
  app_name = "httpd"
}

locals "secret_key" {
    key = "${var.secret_key}"
    sensitive = true
}


# builder need plugin parameters

source "amazon-ebs"  "httpd"{
  ami_name = "PACKER-DEMO-${local.app_name}"
  instance_type = "t2.micro"
  region = ""
  ssh_username =
  tags =  {
      Env  =  "DEMO"
      Name =  "PACKER-DEMO-${vars.app_name}"
  }
}

# usnog build and post processor

build {
  source  = ["source.amazon-ebs.httpd"]
  # configure the VM image
  provisioner "shell" {
    script = script.sh
  }
  # coping files
  provisioner "file" {
    source = "/build/bla/bla"
    destination = "/app/code"
  }
  # after creating the image
  post-procesor "shell-local" {
    inline = ["echo foo"]
  }
}
