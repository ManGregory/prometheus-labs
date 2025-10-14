terraform {
    # список провайдерів які потрібні для кластера
    # це як докер хаб тільки для тераформа
    required_providers {
        # kind кластер, для куба в докері
        kind = {
            source = "tehcyx/kind"
            version = "~> 0.4"
        }
        # kubernetes provider
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "~> 2.23"
        }
        # helm provider
        helm = {
            source = "hashicorp/helm"
            version = "~> 2.11"
        }
    }
    required_version = ">= 1.0"
}

# опис кожного провайдера
# це для kind, нема шо описувати
provider "kind" {}

# це для кубернетеса, вказуємо де буде знаходить конфіг
provider "kubernetes" {
    config_path = kind_cluster.monitoring.kubeconfig_path
}

# це для хелма, аналогічно вказуємо де буде знаходить конфіг кубернетеса
provider "helm" {
    kubernetes {
        config_path = kind_cluster.monitoring.kubeconfig_path
    }
}