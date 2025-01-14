#vsphere connetion info
vsphere_server     = "VCENTER.DOMAIN.LOCAL"
vsphere_user       = "VCENTERUSER@DOMAIN.LOCAL"
vsphere_password   = "SUPERSECRETPASSWORD"
vsphere_datacenter = "DATACENTERNAME"
vsphere_datastore  = "DATASTORENAME"
#Resource Pool (If no resource pool place in CLUSTER/Resources format)
vsphere_rp           = "VCENTER-CLUSTER/VCENTER-RESOURCES"
vsphere_template     = "SERVER2019-TEMPLATE"
vsphere_folder       = "VCENTERFOLDER"
vsphere_cpu          = "4"
vsphere_Memory       = "8192"
#DHCP Network
vsphere_network      = "VMNETWORK"
#Use linked clones.(Requires a single snapshot on the VM)
vsphere_linkedclones = false
#https://docs.microsoft.com/en-us/previous-versions/windows/embedded/ms912391(v=winembedded.11)?redirectedfrom=MSDN
vsphere_timezone = 020

#VM naming
vm_ddc        = "VMNAME"
ip_address	  = "ENTER IP ADDRESS"
ip_gateway    = "ENTER GATEWAY IP"
ip_subnet     = "24"

#DNS
dns_servers = ["DNS PRIMARY IP", "DNS SECONDARY IP"]

#Join domain
domain_user     = "USERNAME"
domain_password = "SUPERSECRETPASSWORD"
domain          = "DOMAIN.LOCAL"
