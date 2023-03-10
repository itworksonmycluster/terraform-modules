terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.13"
    }
  }
}


provider "proxmox" {
  pm_api_url  = "https://proxmox.rafael.tips:8006/api2/json"
  pm_tls_insecure = true
}