resource "helm_release" "botkube" {
  name              = "botkube"
  repository        = "https://infracloudio.github.io/charts"
  chart             = "botkube"
  namespace         = "botkube"
  create_namespace  = true
  wait              = false
  reset_values      = true
  cleanup_on_fail   = true
  force_update      = true
  dependency_update = true
  lint              = true
  max_history       = 3
  values            = ["${file("${path.module}/values/botkube_values.yaml")}"]
}
