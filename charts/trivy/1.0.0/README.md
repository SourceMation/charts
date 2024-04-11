# Useful links / Przydatne linki
- https://aquasecurity.github.io/trivy/v0.28.1/docs/kubernetes/operator/installation/helm/
- https://aquasecurity.github.io/trivy/v0.50/
- https://github.com/aquasecurity/trivy

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export TRIVY_NAMESPACE=trivy
export SERVICE_PORT=<service port for example 9090>
export CHART_VERSION=0.7.0

kubectl create ns ${TRIVY_NAMESPACE}
kubectl config set-context --current --namespace=${TRIVY_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install trivy \
 --set "service.port=${SERVICE_PORT}" \
 --set "trivy.vulnType=os\,library" \
 --set="trivy.ignoreUnfixed=true" \
 --repo https://aquasecurity.github.io/helm-charts/ trivy --version ${CHART_VERSION}
```
