data "hcloud_zone" "main" {
  provider = hcloud.dns

  count = var.include_dns ? 1 : 0

  name = var.domain
}

resource "hcloud_rrset" "hosta" {
  provider = hcloud.dns

  count = var.include_dns ? 1 : 0

  zone = data.hcloud_zone.main.name
  name = var.name
  type = "A"
  ttl  = 120
  records = [
    { value = hcloud_server.playground.ipv4_address },
  ]
}

resource "hetznerdns_record" "hostaaaa" {
  provider = hcloud.dns

  count = var.include_dns ? 1 : 0

  zone = data.hcloud_zone.main.name
  name = var.name
  type = "AAAA"
  ttl  = 120
  records = [
    { value = hcloud_server.playground.ipv6_address },
  ]
}

resource "hetznerdns_record" "wildcard" {
  provider = hcloud.dns

  count = var.include_dns ? 1 : 0

  zone = data.hcloud_zone.main.name
  name = "*.${var.name}"
  type = "CNAME"
  ttl  = 120
  records = [
    { value = hetznerdns_record.hosta[0].name },
  ]
}
