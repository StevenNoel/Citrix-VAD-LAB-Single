provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.vsphere_rp}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_folder" "folder" {
  path          = "${var.vsphere_folder}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "ddc" {
  name             = "${var.vm_ddc}"
  count            = 1
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${vsphere_folder.folder.path}"
  num_cpus         = "${var.vsphere_cpu}"
  memory           = "${var.vsphere_Memory}"
  guest_id         = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "${var.vm_ddc}"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    linked_clone = "${var.vsphere_linkedclones}"

    customize {
      windows_options {
        computer_name         = "${var.vm_ddc}"
        join_domain           = "${var.domain}"
        domain_admin_user     = "${var.domain_user}"
        domain_admin_password = "${var.domain_password}"
        time_zone             = "${var.vsphere_timezone}"
      }
	  network_interface {
        ipv4_address = "${var.ip_address}"
        ipv4_netmask = "${var.ip_subnet}"
		dns_server_list = "${var.dns_servers}"
	    dns_domain = "${var.domain}"
	  }
      ipv4_gateway = "${var.ip_gateway}"
	  
    }
  }
}