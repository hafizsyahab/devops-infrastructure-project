# DevOps Infrastructure Project

Hands-on practice project covering containerization, CI/CD, Kubernetes, and Infrastructure as Code. Everything runs locally (Docker Desktop + kind), no cloud account required.

## Structure

| Folder | Contents |
|---|---|
| `docker/` | Dockerfile, Docker Compose setup, custom nginx HTML |
| `.github/workflows/` | GitHub Actions pipeline: builds the Docker image and pushes it to Docker Hub on every push to `main` |
| `kubernetes/` | Manifests for Deployment, Service, Ingress, ConfigMap, Secret, PV/PVC, HPA, VPA, probes, plus a k6 load test (`loadtest.js`) |
| `terraform/` | `01-cluster`: creates a local kind cluster. `02-app`: deploys an app (namespace, Deployment, Service) through a reusable module |

## What was practiced

- **Docker:** Dockerfile, Compose (custom networks, volumes), Docker Hub push/pull
- **CI/CD:** GitHub Actions pipeline with credentials stored as repository secrets
- **Kubernetes:** Deployments, Services, Ingress (multi-path routing), ConfigMap/Secret, liveness/readiness probes, rolling updates, HPA (CPU and memory, custom scaling behavior) verified with k6 load testing (2 to 6 replicas)
- **Terraform:** init/plan/apply/destroy, variables, outputs, a reusable module, provisioning a Kubernetes cluster

## How to run

### Docker

```
cd docker
docker compose up -d
```

### Kubernetes (requires a running cluster, e.g. kind via Docker Desktop)

```
cd kubernetes
kubectl apply -f deployment.yaml -f service.yaml
```

Other manifests (Ingress, HPA, ConfigMap, etc.) are applied the same way. HPA needs metrics-server; on a local kind cluster it requires the `--kubelet-insecure-tls` flag (local development only).

### Terraform (requires Docker Desktop)

```
cd terraform/01-cluster
terraform init
terraform apply

cd ../02-app
copy terraform.tfvars.example terraform.tfvars
terraform init
terraform apply
```

To tear down, destroy `02-app` first, then `01-cluster`. Creating the cluster takes about 10 minutes.

## Notes

- Terraform state files and kubeconfig are excluded via `.gitignore` because they contain private cluster keys. They are generated locally when you run `terraform apply`.
- `kubernetes/secret.yaml` contains a sample value only.
