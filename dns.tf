data "hetznerdns_zone" "main" {
  count = var.include_dns ? 1 : 0

  name = var.domain
}

resource "hetznerdns_record" "hosta" {
  count = var.include_dns ? 1 : 0

  zone_id = data.hetznerdns_zone.main[0].id
  name    = var.name
  value   = hcloud_server.playground.ipv4_address
  type    = "A"
  ttl     = 120
}

resource "hetznerdns_record" "hostaaaa" {
  count = var.include_dns ? 1 : 0

  zone_id = data.hetznerdns_zone.main[0].id
  name    = var.name
  value   = hcloud_server.playground.ipv6_address
  type    = "AAAA"
  ttl     = 120
}

resource "hetznerdns_record" "wildcard" {
  count = var.include_dns ? 1 : 0

  zone_id = data.hetznerdns_zone.main[0].id
  name    = "*.${var.name}"
  value   = hetznerdns_record.hosta[0].name
  type    = "CNAME"
  ttl     = 120
}
