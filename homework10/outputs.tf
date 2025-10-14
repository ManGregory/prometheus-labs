# файл з описом того які значення ми хочемо побачити після apply, plan
output "cluster_name" {
    description = "Name of the cluster"
    value = kind_cluster.monitoring.name
}

output "kubeconfig_path" {
    description = "Path to kubeconfig file"
    value = kind_cluster.monitoring.kubeconfig_path
}

output "grafana_url" {
    description = "URL to access grafana"
    value = "http://localhost:3000"
}

output "prometheus_url" {
    description = "URL to access prometheus"
    value = "http://localhost:9090"
}

output "kubectl_config" {
    description = "Command to configure kubectl"
    value = "export KUBECONFIG=${kind_cluster.monitoring.kubeconfig_path}"
}