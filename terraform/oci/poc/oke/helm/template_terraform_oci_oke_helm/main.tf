module "metrics-server" {
  source = "./modules/metrics_server/"
}

module "kube_state_metrics" {
  source = "./modules/kube_state_metrics/"
}

# module "istio" {
#   source = "./modules/istio/"
# }

module "istio_local" {
  source = "./modules/istio_local/"
}

module "kubenav" {
  source = "./modules/kubenav/"
}
