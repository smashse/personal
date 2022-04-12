resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
    annotations = {
      "app.kubernetes.io/managed-by" : "Helm"
      "meta.helm.sh/release-namespace" : "istio-system"
    }
  }
}
