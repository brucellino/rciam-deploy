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
