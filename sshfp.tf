# https://de.wikipedia.org/wiki/SSHFP_Resource_Record

resource "tls_private_key" "host-rsa" {
  count = var.include_sshfp ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "host-ecdsa" {
  count = var.include_sshfp ? 1 : 0

  algorithm = "ECDSA"
}

resource "tls_private_key" "host-ed25519" {
  count     = var.include_sshfp ? 1 : 0
  algorithm = "ECDSA"
}

resource "hetznerdns_record" "sshfp-rsa" {
  provider = hcloud.dns

  count = var.include_sshfp ? 1 : 0

  zone_id = data.hetznerdns_zone.main[0].id
  name    = var.name
  type    = "SSHFP"
  ttl     = 120
  records = [
    { value = "1 2 ${tls_private_key.host-rsa[0].public_key_fingerprint_sha256}" },
  ]
}

resource "hetznerdns_record" "sshfp-ecdsa" {
  provider = hcloud.dns

  count = var.include_sshfp ? 1 : 0

  zone_id = data.hetznerdns_zone.main[0].id
  name    = var.name
  type    = "SSHFP"
  ttl     = 120
  records = [
    { value = "3 2 ${tls_private_key.host-ecdsa[0].public_key_fingerprint_sha256}" },
  ]
}

resource "hetznerdns_record" "sshfp-ed25519" {
  provider = hcloud.dns

  count = var.include_sshfp ? 1 : 0

  zone_id = data.hetznerdns_zone.main[0].id
  name    = var.name
  type    = "SSHFP"
  ttl     = 120
  records = [
    { value = "4 2 ${tls_private_key.host-ed25519[0].public_key_fingerprint_sha256}" },
  ]
}
