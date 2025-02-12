# Useful links / Przydatne linki
- https://github.com/neuvector/neuvector
- https://github.com/neuvector/neuvector-helm

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=neuvector
export CHART_VERSION=2.7.3
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install -n  ${CHART_NAMESPACE} neuvector --repo https://neuvector.github.io/neuvector-helm/  crd --version ${CHART_VERSION}
```
