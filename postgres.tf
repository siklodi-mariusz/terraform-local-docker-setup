data "docker_registry_image" "postgres" {
  name = "postgres"
}

resource "docker_image" "postgres" {
  name         = "${data.docker_registry_image.postgres.name}:${var.postgresql_version}"
  keep_locally = false
  pull_triggers = [data.docker_registry_image.postgres.sha256_digest]
}

resource "docker_volume" "postgres" {
  name = "postgres_data"
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.name
  restart = "always"
  ports {
    internal = 5432
    external = 5432
  }
  volumes {
    volume_name    = docker_volume.postgres.name
    container_path = "/var/lib/postgresql/data"
  }
}
