variable "name" {
  type = string
}

variable "domain" {
  type = string
}

variable "location" {
  type = string
}

variable "type" {
  type = string
}

variable "image_name" {
  type    = string
  default = null
}

variable "image_filter" {
  type    = string
  default = null
}

variable "cloud_init_user_data" {
  type    = string
  default = ""
}

variable "include_dns" {
  type    = bool
  default = true
}

variable "include_certificate" {
  type    = bool
  default = false
}

variable "use_letsencrypt_staging_ca" {
  type    = bool
  default = false
}

variable "additional_subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "include_sshfp" {
  type    = bool
  default = false
}

variable "hcloud_token" {
  sensitive = true
}

variable "hetznerdns_token" {
  sensitive = true
}