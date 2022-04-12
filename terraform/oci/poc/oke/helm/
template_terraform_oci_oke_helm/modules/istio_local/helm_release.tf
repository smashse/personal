variable "istio" {
  type    = string
  default = "./modules/istio_local/istio/manifests/charts"
}

variable "istiocontrol" {
  type    = string
  default = "./modules/istio_local/istio/manifests/charts/istio-control"
}

variable "istiogateways" {
  type    = string
  default = "./modules/istio_local/istio/manifests/charts/gateways"
}

variable "profile" {
  description = "Profile"
  type        = list(any)
  default = [
    "default",
  ]
}

resource "helm_release" "istio_operator" {
  name              = "istio-operator"
  repository        = var.istio
  chart             = "istio-operator"
  namespace         = "istio-system"
  create_namespace  = true
  wait              = false
  reset_values      = true
  cleanup_on_fail   = true
  force_update      = true
  dependency_update = true
  lint              = true
  depends_on        = [kubernetes_namespace.istio_system]

  max_history = 3

  set {
    name  = "profile"
    value = "{${join(",", var.profile)}}"
  }
}

resource "helm_release" "istio_base" {
  name              = "istio-base"
  repository        = var.istio
  chart             = "base"
  namespace         = "istio-system"
  create_namespace  = true
  wait              = false
  reset_values      = true
  cleanup_on_fail   = true
  force_update      = true
  dependency_update = true
  lint              = true
  depends_on        = [kubernetes_namespace.istio_system]
  max_history       = 3
}

resource "helm_release" "istio_discovery" {
  name              = "istio-discovery"
  repository        = var.istiocontrol
  chart             = "istio-discovery"
  namespace         = "istio-system"
  create_namespace  = true
  wait              = false
  reset_values      = true
  cleanup_on_fail   = true
  force_update      = true
  dependency_update = true
  lint              = true
  depends_on        = [kubernetes_namespace.istio_system]
  max_history       = 3
}

resource "helm_release" "istio_ingress" {
  name              = "istio-ingress"
  repository        = var.istiogateways
  chart             = "istio-ingress"
  namespace         = "istio-system"
  create_namespace  = true
  wait              = false
  reset_values      = true
  cleanup_on_fail   = true
  force_update      = true
  dependency_update = true
  lint              = true
  depends_on        = [kubernetes_namespace.istio_system]
  max_history       = 3
  values = ["${file("${path.module}/values/ingress_values.yaml")}"]
}

resource "helm_release" "istio_egress" {
  name              = "istio-egress"
  repository        = var.istiogateways
  chart             = "istio-egress"
  namespace         = "istio-system"
  create_namespace  = true
  wait              = false
  reset_values      = true
  cleanup_on_fail   = true
  force_update      = true
  dependency_update = true
  lint              = true
  depends_on        = [kubernetes_namespace.istio_system]
  max_history       = 3
}
