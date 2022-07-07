provider "vault"{
    skip_tls_verify = true
}
data "vault_generic_secret" "vmware"{
    path = "secrets/vmware"
}
provider "vsphere" {
    user = "${data.vault_generic_secret.vmware.data["username"]}"
    password = "${data.vault_generic_secret.vmware.data["password"]}"
    vsphere_server = "${data.vault_generic_secret.vmware.data["server"]}"
    alllow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
    name = "${data.vault_generic_secret.vmware.data["datacenter"]}"
}


data "vsphere_datastore" "datastore" {
    name = "${data.vault_generic_secret.vmware.data["esx_datastore"]}"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
    name = "${data.vault_generic_secret.vmware.data["cluster"]}"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


data "vsphere_network" "network" {
    name = "VM Network"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "template" {
    name = "packer ubuntu 20"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

variable "compute_prefix" {
    type = string
    default  = "vuws"
}
resource "vsphere_virtual_machine" "ubuntu" {
    name = "ubuntu01"
    resource_pool_id =
    datastore_id =

    num_cpu =  4
    memory =
    guest_id =
    scsi_type =

    enable_logging = true

    network_interface {
        network_id =
        network_type =
    }
    disk {
      label =
      size =
      eagerly_scrub =
      thin_provisioned =
    }
    clone {
        template_uuid =
        customize {
            timeout =
            linux_pptions {

            }
            network_interface {

            }
        }
    }

    provisioner "file" {
        source = "../../keys/mykeys.pub"
        destination = "/home/ubuntu/mykeys.pub"

        conection {
            type = "ssh"
            user = "ubuntu"
            password = "ubuntu"
            host = self.default_ip_address
        }
    }

    provisioner "remote-exec" {
        inline= [
              "sudo mkdir -p /home/ubuntu/.ssh",
              "sudo chmod 700 /home/ubuntu/.ssh",
              "sudo touch /home/ubuntu/.ssh/authorized_keys",
              "sudo sh -c 'cat /home/ubuntu/mykey.pub > /home/ubuntu/.ssh/authorized_keys'",
              "sudo chown -R ubuntu: /home/ubuntu/.ssh",
              "sudo chmod -R 644 /home/ubuntu/.ssh/authorized_keys",
              "sudo rm -rf /home/ubuntu/mykey.pub"
        ]
        connection {
              type = "ssh"
              user = "ubuntu"
              password = "ubuntu"
              host = self.default_ip_address
        }
    }
}

output "final" {
      value  = "${formatlist("%v - %v",vsphere_virtual_machine.ubuntu.*.default_ip_address, vsphere.vsphere_virtual_machine.ubuntu.*.name)}"
}
