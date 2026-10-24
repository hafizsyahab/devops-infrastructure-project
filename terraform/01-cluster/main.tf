terraform {
    required_providers {
        kind = {
            source = "tehcyx/kind"
        }
    }
}

provider "kind" {}

resource "kind_cluster" "lab" {
    name           = "tf-lab"
    wait_for_ready = true
}

output "kubeconfig_path" {
    value = kind_cluster.lab.kubeconfig_path
}
