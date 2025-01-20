output "name" {
    value = var.name
}

output "image" {
    value = hcloud_image.image.id
}

output "ipv4" {
    value = hcloud_server.playground.ipv4_address
}

output "ipv6" {
    value = hcloud_server.playground.ipv6_address
}

output "ssh_private_key" {
    value = tls_private_key.ssh_private_key.private_key_openssh
}

output "ssh_fingerprint_sha256" {
    value = tls_private_key.ssh_private_key.public_key_fingerprint_sha256
}
