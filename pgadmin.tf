data "docker_registry_image" "pgadmin4" {
  name = "dpage/pgadmin4"
}

resource "docker_image" "pgadmin4" {
  name          = data.docker_registry_image.pgadmin4.name
  keep_locally  = false
  pull_triggers = [data.docker_registry_image.pgadmin4.sha256_digest]
}

resource "docker_volume" "pgadmin4" {
  name = "pgadmin4"
}

resource "docker_container" "pgadmin4" {
  name    = "pgadmin4"
  image   = docker_image.pgadmin4.latest
  restart = "always"
  env = [
    "PGADMIN_DEFAULT_EMAIL=${var.pgadmin_default_email}",
    "PGADMIN_DEFAULT_PASSWORD=${var.pgadmin_default_password}"
  ]
  ports {
    internal = 80
    external = 9091
  }
  volumes {
    volume_name    = docker_volume.pgadmin4.name
    container_path = "/var/lib/pgadmin"
  }
}
