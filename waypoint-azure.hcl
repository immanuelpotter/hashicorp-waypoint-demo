# The name of your project. A project typically maps 1:1 to a VCS repository.
# This name must be unique for your Waypoint server. If you're running in
# local mode, this must be unique to your machine.
project = "hashicorp-waypoint-demo"

# An application to deploy.
app "flask" {
    labels = {
        "service" = "flask-webapp-azure",
        "env"     = "dev"
    }
    # Build specifies how an application should be deployed. In this case,
    # we'll build using a Dockerfile and keeping it in a local registry.
    build {
        use "docker" {} # Essentially a vanilla docker build, locally.
        
    registry {
      use "docker" {
        image = "<my-container-registry>.azurecr.io/example-nodejs"
        tag   = "latest"
      }
    }

    # Deploy to ACI (Azure Container Instances)
    deploy {
        use "azure-container-instance" {
            resource_group = "DefaultResourceGroup-EUS"
            location       = "eastus"
            ports          = [5000]

            capacity {
                memory    = "512"
                cpu_count = 1
            }
        }
    }
}

#   build {
#     use "pack" {} # what is pack, for azure example?