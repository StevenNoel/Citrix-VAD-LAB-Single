variable "vsphere_server" {
  description = "vsphere server for the environment"
}

variable "vsphere_user" {
  description = "vsphere server for the environment"
}

variable "vsphere_password" {
  description = "vsphere server password for the environment"
}

variable "vsphere_datacenter" {
  description = "vsphere datacenter"
}

variable "vsphere_datastore" {
  description = "vsphere datastore to deploy"
}

variable "vsphere_rp" {
  description = "vsphere resource pool"
}

variable "vsphere_template" {
  description = "vsphere template or vm to clone"
}

variable "vsphere_network" {
  description = "vsphere network for deployed vms"
}

variable "domain_user" {
  description = "Domain Admin User"
}

variable "domain_password" {
  description = "Domain Admin Password"
}

variable "domain" {
  description = "Domain to join"
}

variable "ip_address" {
  description = "IP Address"
}

variable "ip_gateway" {
  description = "IP Address Gateway"
}

variable "ip_subnet" {
  description = "IP Address Subnet Mask"
}

variable "dns_servers" {
  description = "IP Address Subnet Mask"
}

variable "vsphere_linkedclones" {
  description = "Use linked clones to deploy"
}

variable "vm_ddc" {
  description = "Prefix for DDC servers"
}

variable "vsphere_timezone" {
  description = "TimeZone to use for deployed machines"
}

variable "vsphere_folder" {
  description = "vcenter folder"
}

variable "vsphere_cpu" {
  description = "Number of CPUs"
}

variable "vsphere_Memory" {
  description = "Memory size in MB"
}