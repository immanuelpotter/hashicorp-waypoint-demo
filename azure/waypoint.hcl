# The name of your project. A project typically maps 1:1 to a VCS repository.
# This name must be unique for your Waypoint server. If you're running in
# local mode, this must be unique to your machine.
project = "hashicorp-waypoint-demo"

# An application to deploy.
app "waypoint-flask-demo-azure" {
  labels = {
    "service" = "flask-webapp-azure-waypoint-demo",
    "env"     = "dev"
  }
  # Build specifies how an application should be deployed. In this case,
  # we'll build using a Dockerfile and keeping it in a local registry.
  build {
    use "docker" {} # Essentially a vanilla docker build, locally.

    registry {
      use "docker" {
        region = "eastus"
        tag   = "latest"
      }
    }
  }

  # Deploy to ACI (Azure Container Instances)
  deploy {
    use "azure-container-instance" {
      resource_group = "waypoint-demo"
      location       = "eastus"
      ports          = [5000]

      capacity {
        memory    = "512"
        cpu_count = 1
      }
    }
  }
}