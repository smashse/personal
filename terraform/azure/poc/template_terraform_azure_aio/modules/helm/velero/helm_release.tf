resource "helm_release" "velero" {
  name              = "velero"
  repository        = "https://vmware-tanzu.github.io/helm-charts"
  chart             = "velero"
  namespace         = "velero"
  create_namespace  = true
  wait              = false
  reset_values      = true
  cleanup_on_fail   = true
  force_update      = true
  dependency_update = true
  lint              = true
  max_history       = 3
  values            = ["${file("${path.module}/values/velero_values.yaml")}"]
}
