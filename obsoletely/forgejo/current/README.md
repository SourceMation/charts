# Useful links / przydatne linki
- https://code.forgejo.org/forgejo-contrib/forgejo-helm
- https://codeberg.org/forgejo-contrib/-/packages/container/forgejo/0.8.0

# Installation / Instalacja
## Preparation / Przygotowanie
```bash
export CHART_NAMESPACE=forgejo
export CHART_VERSION=0.8.0

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE
```

## Installation via helm / Instalacja przy użyciu helm
``` bash
helm install forgejo oci://codeberg.org/forgejo-contrib/forgejo
```
