# The name of your project. A project typically maps 1:1 to a VCS repository.
# This name must be unique for your Waypoint server. If you're running in
# local mode, this must be unique to your machine.
project = "hashicorp-waypoint-demo"

# An application to deploy.
app "flask" {
  labels = {
    "service" = "flask-webapp-aws-waypoint-demo",
    "env"     = "dev"
  }
  # Build specifies how an application should be deployed. In this case,
  # we'll build using a Dockerfile and keeping it in a local registry.
  build {
    use "docker" {} # Essentially a vanilla docker build, locally.

    registry {        # Use a remote registry
      use "aws-ecr" { # In AWS, that doesn't exist yet - make it for us
        region = "eu-west-2"
        tag    = "latest"
      }
    }
  }

  # Deploy to ECS (Fargate)
  deploy {
    use "aws-ecs" {
      region       = "eu-west-2"
      memory       = 512
      service_port = 5000
    }
  }
}
