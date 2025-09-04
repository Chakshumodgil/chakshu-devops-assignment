# Task (Helm-J-1): Install Existing Chart (Simulated)

## Use Case
Simulate the installation of the official `bitnami/nginx` chart into a namespace named `webserver`. Override the `service.type` to `LoadBalancer`.

## Helm command (simulate with dry-run)
```powershell
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install my-nginx bitnami/nginx --namespace webserver --create-namespace --set service.type=LoadBalancer --dry-run --debug
``` 