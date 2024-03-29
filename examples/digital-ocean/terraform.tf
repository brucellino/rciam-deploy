terraform {
  required_version = "~> 1.7"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.36"
    }
  }
  backend "local" {}
}

provider "digitalocean" {}