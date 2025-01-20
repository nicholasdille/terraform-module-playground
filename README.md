# Terraform module for playground VM

Deploy a virtual machine on Hetzner Cloud with a DNS record in the Hetzner DNS service

## Usage

See the following example how to use the module:

```hcl
module "foo" {
    source = "github.com/nicholasdille/terraform-module-playground"

    name = "playground"
    domain = "inmylab.de"
    location = "fsn1"
    type = "cpx32"

    hcloud_token = var.hcloud_token
    hetznerdns_token = var.hetznerdns_token

    include_certificate = true
    include_sshfp = false
}
```

See the [official documentation](https://developer.hashicorp.com/terraform/language/modules/sources#selecting-a-revision) how to pin the module to a specific version/revision.

## Arguments

The following arguments are supported:

| Argument            | Type   | Default | Description             |
| ------------------- | ------ | ------- | ----------------------- |
| name                | string |         | Name of the VM          |
| domain              | string |         | Name of the DNS zone    |
| location            | string |         | Location of the VM, see [API](https://docs.hetzner.cloud/#locations) |
| type                | string |         | Type of the VM, see [website](https://www.hetzner.com/de/cloud/) or [API](https://docs.hetzner.cloud/#server-types) |
| hcloud_token        | string |         | Hetzner Cloud API token, see [API](https://docs.hetzner.cloud/#authentication) |
| hetznerdns_token    | string |         | Hetzner DNS API token, see [API](https://dns.hetzner.com/api-docs) |
| include_certificate | bool   | false   | Include certificate     |
| include_sshfp       | bool   | false   | Include SSHFP record    |

## Outputs

The following outputs are provided:

| Output                 | Type   | Description                       |
| ---------------------- | ------ | --------------------------------- |
| name                   | string | Name of the VM                    |
| ipv4                   | string | IPv4 address of the VM            |
| ipv6                   | string | IPv6 address of the VM            |
| ssh_private_key        | string | Path to the SSH private key       |
| ssh_fingerprint_sha256 | string | Fingerprint of the SSH public key |

## Opinionated configuration

Documentation of some design decisions

### SSH

The SSH private key is created as part of the state.

The SSH private key is placed in `/etc/ssh/NAME_ssh`.

An SSH config file for virtual machine is placed in `~/.ssh/config.d/NAME`.

### DNS

A and AAAA records are created for NAME.ZONE pointing to the IPv4 and IPv6 address, respectively.

A wirdcard CNAME record is created to point to the IPv4 address.

### TLS

Certificates are obtained from Let's Encrypt using the DNS challenge against Hetzner DNS.

Certificates for the A as well as the wildcard CNAME records are automatically created and placed in `/etc/ssl/tls.{key,crt,chain}`.

## TODO

- [ ] Finish support for SSHFP records
- [ ] Allow additional CNAME record for the A record
- [ ] Allow additional alternative subject names in the certificate
