# Useful links / Przydatne linki
- https://cert-manager.io/
- https://github.com/cert-manager/cert-manager
- https://cert-manager.io/docs/installation/helm/

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=cert-manager
export CHART_VERSION=1.14.4
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
kubectl -n ${CHART_NAMESPACE} apply -f https://github.com/cert-manager/cert-manager/releases/download/v${CHART_VERSION}/cert-manager.crds.yaml

helm upgrade --install cert-manager \
 -n ${CHART_NAMESPACE} \
 -f https://raw.githubusercontent.com/sourcemation/charts/main/charts/cert-manager/${CHART_VERSION}/values \
 --repo https://charts.jetstack.io cert-manager --version ${CHART_VERSION}
```
