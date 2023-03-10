locals {
  vm = yamldecode(file("configs/vm.yml"))["vms"]
}


# module "vms" {
#   source = "git@github.com:itworksonmycluster/terraform-modules.git//proxmox-virtual-machine"
# }

module "vms" {
  source   = "../../"
  for_each = local.vm
  config   = local.vm[each.key]
}