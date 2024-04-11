# Useful links / Przydatne linki
- https://charts.kubewarden.io/

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=kubewarden
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install kubewarden-crd --repo https://charts.kubewarden.io kubewarden-crds 
helm upgrade --install kubewarden-controller --repo https://charts.kubewarden.io kubewarden-controller 
helm upgrade --install kubewarden-defaults --repo https://charts.kubewarden.io kubewarden-defaults
```
