variable "istio" {
  type    = string
  default = "https://istio-release.storage.googleapis.com/charts"
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
  repository        = var.istio
  chart             = "istiod"
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

resource "helm_release" "istio_ingress" {
  name              = "istio-ingress"
  repository        = var.istio
  chart             = "gateway"
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

resource "helm_release" "istio_egress" {
  name              = "istio-egress"
  repository        = var.istio
  chart             = "gateway"
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
