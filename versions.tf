terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.49.1"
    }
    hetznerdns = {
      source  = "germanbrew/hetznerdns"
      version = "3.3.3"
    }
    acme = {
      source  = "vancluever/acme"
      version = "2.35.0"
    }
    remote = {
      source  = "tenstad/remote"
      version = "0.1.3"
    }
    ssh = {
      source  = "loafoe/ssh"
      version = "2.7.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
  }
}