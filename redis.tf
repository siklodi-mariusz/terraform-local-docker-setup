data "docker_registry_image" "redis" {
  name = "redis"
}

resource "docker_image" "redis" {
  name         = data.docker_registry_image.redis.name
  keep_locally = false
  pull_triggers = [data.docker_registry_image.redis.sha256_digest]
}

resource "docker_volume" "redis" {
  name = "redis_data"
}

resource "docker_container" "redis" {
  name  = "redis"
  image = docker_image.redis.latest
  restart = "always"
  ports {
    internal = 6379
    external = 6379
  }
  volumes {
    volume_name    = docker_volume.redis.name
    container_path = "/data"
  }
}
