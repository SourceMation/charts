# Useful links / Przydatne linki
- https://github.com/bitnami-labs/sealed-secrets
- https://github.com/bitnami-labs/sealed-secrets/releases


# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=sealed-secrets
export CHART_VERSION=2.15.2
export INGRESS_HOST=sealed-secrets.example.com
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm upgrade --install sealed-secrets \
 -n ${CHART_NAMESPACE} \
 -f https://raw.githubusercontent.com/sourcemation/charts/main/charts/sealed-secrets/${CHART_VERSION}/values \
 --set server.ingress.hosts[0].host=${INGRESS_HOST} \
 --repo https://bitnami-labs.github.io/sealed-secrets sealed-secrets --version ${CHART_VERSION}
```
