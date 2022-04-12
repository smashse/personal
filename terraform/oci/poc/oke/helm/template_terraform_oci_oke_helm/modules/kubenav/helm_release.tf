resource "helm_release" "kubenav" {
  name              = "kubenav"
  repository        = "https://kubenav.github.io/helm-repository"
  chart             = "kubenav"
  namespace         = "kubenav"
  create_namespace  = true
  wait              = false
  reset_values      = true
  cleanup_on_fail   = true
  force_update      = true
  dependency_update = true
  lint              = true
  max_history       = 3
}
