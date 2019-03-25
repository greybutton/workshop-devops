provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "web-2" {
  image  = "docker-18-04"
  name   = "web-2"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.greybutton.fingerprint}"]
}

resource "digitalocean_ssh_key" "greybutton" {
  name = "greybutton"
  public_key = "${file("./files/greybutton.pub")}"
}
