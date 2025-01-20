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

The following arguments are supported

| Argument            | Type   | Default | Description             |
| ------------------- | ------ | ------- | ----------------------- |
| name                | string |         | Name of the VM          |
| domain              | string |         | Domain name             |
| location            | string |         | Location of the VM      |
| type                | string |         | Type of the VM          |
| hcloud_token        | string |         | Hetzner Cloud API token |
| hetznerdns_token    | string |         | Hetzner DNS API token   |
| include_certificate | bool   | false   | Include certificate     |
| include_sshfp       | bool   | false   | Include SSHFP record    |
