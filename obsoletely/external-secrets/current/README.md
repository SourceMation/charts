# Useful links / Przydatne linki
- https://external-secrets.io/latest/
- https://github.com/external-secrets/external-secrets

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=external-secrets
export CHART_VERSION=0.9.13
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```
## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install external-secrets \
 -n ${CHART_NAMESPACE} \
 -f https://raw.githubusercontent.com/sourcemation/charts/main/charts/external-secrets/${CHART_VERSION}/values
 --repo https://charts.external-secrets.io external-secrets --version ${CHART_VERSION}
```
