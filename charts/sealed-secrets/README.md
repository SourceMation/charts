# Useful links / Przydatne linki
- https://github.com/bitnami-labs/sealed-secrets
- https://github.com/bitnami-labs/sealed-secrets/releases


# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export RELEASE_NAME=sealed-secrets
export CHART_NAME=sealed-secrets
export RELEASE_NAMESPACE=sealed-secrets
export CHART_VERSION=2.15.2
export INGRESS_HOST=sealed-secrets.example.com

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace=${RELEASE_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm

```bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
-f https://raw.githubusercontent.com/sourcemation/charts/main/charts/sealed-secrets/values \
--set server.ingress.hosts[0].host=${INGRESS_HOST} \
${CHART_NAME} --repo https://bitnami-labs.github.io/sealed-secrets \ --version ${CHART_VERSION}
```
