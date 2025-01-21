data "hcloud_image" "image" {
  with_selector = var.image_filter
  most_recent   = true
}

resource "hcloud_server" "playground" {
  name        = var.name
  location    = var.location
  server_type = var.type
  image       = data.hcloud_image.image.id
  ssh_keys = [
    hcloud_ssh_key.ssh_public_key.name
  ]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  user_data = var.cloud_init_user_data
  labels = {
    "purpose" : var.name
  }
}