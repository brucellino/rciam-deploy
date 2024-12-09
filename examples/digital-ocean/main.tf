resource "digitalocean_vpc" "rciam" {
  name   = "rciam-${var.deployment_name}"
  region = var.region
}

resource "digitalocean_database_cluster" "rciam" {
  name       = "rciam-db-${var.deployment_name}"
  engine     = "pg"
  version    = var.pg_version
  region     = var.region
  node_count = 1
  size       = var.db_size
}

resource "digitalocean_database_user" "rciam" {
  name       = var.db_user
  cluster_id = digitalocean_database_cluster.rciam.id
}

resource "digitalocean_database_db" "rciam" {
  name       = var.db_name
  cluster_id = digitalocean_database_cluster.rciam.id
}

resource "digitalocean_ssh_key" "rciam" {
  name       = "value"
  public_key = file("${path.module}/do.pub")
}

data "digitalocean_images" "ubuntu" {
  filter {
    key    = "distribution"
    values = ["Ubuntu"]
  }
  filter {
    key    = "regions"
    values = ["ams3"]
  }

  sort {
    key       = "name"
    direction = "desc"
  }
}
resource "digitalocean_droplet" "keycloak" {
  name          = "keycloak-${var.deployment_name}"
  vpc_uuid      = digitalocean_vpc.rciam.id
  size          = "value"
  ssh_keys      = [digitalocean_ssh_key.rciam.id]
  image         = data.digitalocean_images.ubuntu.images[0].id
  backups       = false
  monitoring    = true
  ipv6          = false
  region        = "ams3"
  droplet_agent = true
}

resource "digitalocean_database_firewall" "keycloak" {
  cluster_id = digitalocean_database_cluster.rciam.id
  rule {
    type  = "droplet"
    value = digitalocean_droplet.keycloak.id
  }
}


# name: Configure PostgreSQL client authentication
# name: Configure PostgreSQL users
# name: Configure privileges of PostgreSQL users
# name: Configure PostgreSQL databases
