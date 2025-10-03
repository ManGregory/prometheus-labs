# опис ресурса kind
# це ім'я щоб можна було звертатись в інших файлах tf
resource "kind_cluster" "monitoring" {
    name = "monitoring-cluster"

    # опис конфігурації для кластера в kind
    kind_config {
        # тип
        kind = "Cluster"
        # яка версія api
        api_version = "kind.x-k8s.io/v1alpha4"

        # опис нодів
        node {
            # основний нод з сервісами кубернетеса
            role = "control-plane"

            # задаємо мапінги портів графани 30080:3000
            extra_port_mappings {
                container_port = 30080
                host_port = 3000
                protocol = "TCP"
            }

            # задаємо мапінги портів прометеус 30090:9090
            extra_port_mappings {
                container_port = 30090
                host_port = 9090
                protocol = "TCP"
            }            
        }

        # два воркер нода
        # на них поставиться нод експортер автоматом через daemonset
        node {
            role = "worker"
        }

        node {
            role = "worker"
        }
    }
}