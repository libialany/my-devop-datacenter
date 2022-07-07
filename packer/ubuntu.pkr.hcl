local "vcenter_username" {
      expression = value("")
      sensitive = true
}
local "vcenter_password" {
      expression =
      sensitive = true
}

local "vcenter_cluster" {
      expression =
      sensitive = true
}

local "vcenter_datacenter" {
      expression =
      sensitive = true
}
local "esx_datastore" {

}
local "esx_host" {

}

locals {
  builtime =
}

source "vsphere-iso" "ubuntu" {
    vcenter_server  =
    username  =
    password =
    cluster =
    datacenter =
    datastore =
    host =
    folder =
    insecure_connection =

    storage {

    }
    network_adapters {

    }
    iso_paths = {

    }

}

build {
    sources = ["source.vsphere-iso.ubuntu20"]

    provisioner "shell" {
        inline = [
            "echo Running updates",
            "sudo apt-get update",
            "sudo apt-get -y install open-vm-tools",
            "sudo touch /etc/cloud/cloud-init.disabled", # Fixing issues with preboot DHCP
            "sudo apt-get -y purge cloud-init",
            "sudo sed -i \"s/D /tmp 1777/#D /tmp 1777/\" /usr/lib/tmpfiles.d/tmp.conf",
            "sudo sed -i \"s/After=/After=dbus.service /\" /lib/systemd/system/open-vm-tools.service",
            "sudo rm -rf /etc/machine-id", # next four lines fix same ip address being assigned in vmware
            "sudo rm -rf /var/lib/dbus/machine-id",
            "sudo touch /etc/machine-id",
            "sudo ln -s /etc/machine-id /var/lib/dbus/machine-id"
        ]
    }
}
