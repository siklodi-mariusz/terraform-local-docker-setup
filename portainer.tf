data "docker_registry_image" "portainer" {
  name = "portainer/portainer-ce"
}

resource "docker_image" "portainer" {
  name         = data.docker_registry_image.portainer.name
  keep_locally = false
  pull_triggers = [data.docker_registry_image.portainer.sha256_digest]
}

resource "docker_volume" "portainer_data" {
  name = "portainer_data"
}

resource "docker_container" "portainer" {
  name  = "portainer"
  image = docker_image.portainer.latest
  restart = "always"
  ports {
    internal = 8000
    external = 8000
  }
  ports {
    internal = 9000
    external = 9000
  }
  volumes {
    volume_name    = docker_volume.portainer_data.name
    container_path = "/data"
  }
  volumes {
    host_path = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }
}
