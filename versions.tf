terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.49.1"
    }
    acme = {
      source  = "vancluever/acme"
      version = "2.28.1"
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

provider "hcloud" {
  alias = "default"
  token = var.hcloud_token
}

provider "hcloud" {
  alias = "dns"
  token = var.hcloud_dns_token
}

provider "acme" {
  server_url = var.use_letsencrypt_staging_ca ? "https://acme-staging-v02.api.letsencrypt.org/directory" : "https://acme-v02.api.letsencrypt.org/directory"
}