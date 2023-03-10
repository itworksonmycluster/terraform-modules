resource "proxmox_vm_qemu" "vm" {
  name        = var.config.name
  target_node = var.config.target_node
  clone       = var.config.template_name


  vmid     = var.config.vmid != "" ? var.config.vmid : 0
  onboot   = var.config.onboot != "" ? var.config.onboot : false
  oncreate = var.config.oncreate != "" ? var.config.oncreate : true



  agent    = var.config.agent != "" ? var.config.agent : 1
  os_type  = var.config.os_type != "" ? var.config.os_type : "cloud_init"
  cores    = var.config.cores != "" ? var.config.cores : 1
  sockets  = var.config.sockets != "" ? var.config.sockets : 1
  cpu      = "host"
  memory   = var.config.memory != "" ? var.config.memory : 1024
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  dynamic "disk" {
    iterator = disk
    for_each = var.config.disks
    content {      
      size     = disk.value.size != "" ? disk.value.size : "8G"
      type     = "scsi"
      storage  = disk.value.storage != "" ? disk.value.storage : "local-lvm"      
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  # ipconfig0 = "ip=10.98.1.9${count.index + 1}/24,gw=10.98.1.1"

}