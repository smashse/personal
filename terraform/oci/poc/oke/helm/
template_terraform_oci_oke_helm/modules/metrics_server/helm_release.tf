resource "helm_release" "metrics_server" {
  name              = "metrics-server"
  repository        = "https://kubernetes-sigs.github.io/metrics-server/"
  chart             = "metrics-server"
  namespace         = "kube-system"
  create_namespace  = true
  wait              = false
  reset_values      = true
  cleanup_on_fail   = true
  force_update      = true
  dependency_update = true
  lint              = true
  max_history       = 3

  set {
    name  = "args"
    value = "{${join(",", var.args)}}"
  }
}

variable "args" {
  description = "List of additional arguments"
  type        = list(any)
  default = [
    "--kubelet-insecure-tls",
  ]
}
