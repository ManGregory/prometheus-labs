# створюємо неймспейс для моніторінга
resource "kubernetes_namespace" "monitoring" {
    metadata {
        name = "monitoring"
    }
}

# а це буде наш хелм реліз для встановлення моніторінг стеку за допомогою чарта kube_prometheus_stack
resource "helm_release" "kube_prometheus_stack" {
    # назва, репо і т.п.
    name = "kube-prometheus-stack"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart = "kube-prometheus-stack"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
    version = "~> 55.0"

    # різні налаштування чекати і скільки
    wait = true
    wait_for_jobs = true
    timeout = 600

    # по суті values.yaml який буде аргументом для helm install
    values = [
      yamlencode({
        # порт графани
        grafana = {
          service = {
            type = "NodePort"
            nodePort = 30080
          }
        }
        
        # порт прометеус
        prometheus = {
          service = {
            type = "NodePort"
            nodePort = 30090
          }
          
          # servicemonitor буде бачити всі сервіси 
          prometheusSpec = {
            serviceMonitorSelectorNilUsesHelmValues = false
          }
        }
      })
    ]
}