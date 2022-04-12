provider "helm" {
  kubernetes {
    config_path = "~/.kube/configs/config-example-oke-dev"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/configs/config-example-oke-dev"
}
