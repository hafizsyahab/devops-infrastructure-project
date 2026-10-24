resource "kubernetes_deployment_v1" "this" {
    metadata {
        name     = var.name
        namespace = var.namespace
    }
    spec {
      replicas = var.replicas
      selector {
        match_labels = { app = var.name}
      }
      template {
        metadata {
          labels = { app = var.name }
        }
        spec {
          container {
            image = var.image
            name  = var.name
            port {
              container_port = 80
            }
          }
        }
      }
    }
}

resource "kubernetes_service_v1" "this" {
    metadata {
        name      = var.name
        namespace = var.namespace
    }
    spec {
        selector = { app = var.name }
        port {
            port        = 80
            target_port = 80
        }
    }
}
