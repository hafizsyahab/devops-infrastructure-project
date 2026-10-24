terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

variable "kubeconfig_path" {
  type = string
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

resource "kubernetes_namespace_v1" "app" {
  metadata {
    name = "demo"
  }
}

module "web_a" {
  source    = "./modules/web"
  name      = "web-a"
  namespace = kubernetes_namespace_v1.app.metadata[0].name
}

module "web_b" {
  source    = "./modules/web"
  name      = "web-b"
  namespace = kubernetes_namespace_v1.app.metadata[0].name
  replicas  = 1
}

output "services" {
  value = [module.web_a.service_name, module.web_b.service_name]
}