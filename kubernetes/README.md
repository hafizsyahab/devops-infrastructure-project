# Kubernetes Local Practice (kind)

> 🚧 **Status:** Ongoing. Completed Deployments through Ingress and Autoscaling (HPA & VPA). Next: Terraform + AWS.

> ⚠️ **Note on Secrets**
> All values in `secret.yaml` (e.g. `PASSWORD_CONTOH`) are dummy/placeholder data created solely for demonstrating Kubernetes Secret concepts. No real credentials or third-party data are used in this project.

## About

Personal learning project to practice core Kubernetes concepts using a local cluster (kind, running via Docker Desktop). This is not a production deployment. It's a hands-on sandbox to understand how each Kubernetes resource works.

## What's covered

- Control Plane, Pods, and basic cluster architecture
- Deployments & ReplicaSets
- Services
- Namespaces
- ConfigMaps & Secrets
- Persistent Volumes & Persistent Volume Claims
- Health check probes (liveness/readiness)
- Ingress (Ingress Controller + routing via `kubectl port-forward`)
- Horizontal Pod Autoscaling (HPA) with a load test
- Vertical Pod Autoscaler (VPA)
- A basic CI/CD-oriented deployment file (`deployment-cicd.yaml`)

## Files

| File | Purpose |
|---|---|
| `deployment.yaml` | Deployment with resource requests and probes |
| `service.yaml` | Exposing a Deployment via Service |
| `ingress.yaml` | Routing rules for the Ingress Controller |
| `configmap.yaml` | Injecting config data into Pods |
| `secret.yaml` | Injecting sensitive data into Pods |
| `pv.yaml` / `pvc.yaml` | Persistent storage setup |
| `hpa.yaml` | Horizontal Pod Autoscaler |
| `vpa.yaml` | Vertical Pod Autoscaler |
| `loadtest.js` | Load test script to trigger HPA |
| `real-app.yaml` | Small sample app tying concepts together |
| `pod-configmap.yaml` | Pod consuming a ConfigMap |
| `pod-with-pvc.yaml` | Pod consuming a Persistent Volume Claim |
| `deployment-cicd.yaml` | Deployment used for CI/CD pipeline practice |

## Environment

- Local Kubernetes cluster via kind, run through Docker Desktop
- `kubectl` for cluster management

## Rebuilding the cluster from scratch

1. Enable Kubernetes (kind mode) in Docker Desktop.
2. Install the Ingress Controller:
```bash
   kubectl label node desktop-control-plane ingress-ready=true
   kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
```
3. Make sure `metrics-server` is running (required by HPA):
```bash
   kubectl get pods -n kube-system | grep metrics-server
```
4. Install VPA (run in Git Bash or WSL):
```bash
   git clone https://github.com/kubernetes/autoscaler.git
   cd autoscaler/vertical-pod-autoscaler
   ./hack/vpa-up.sh
```
5. Apply the manifests in order:
```bash
   kubectl apply -f configmap.yaml -f secret.yaml
   kubectl apply -f deployment.yaml -f service.yaml -f ingress.yaml
   kubectl apply -f hpa.yaml -f vpa.yaml
```

> The `autoscaler/` folder is only used for installing VPA and is excluded via `.gitignore`.