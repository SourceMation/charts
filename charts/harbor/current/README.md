# Useful links / Przydatne linki
- https://goharbor.io/docs/
- https://github.com/goharbor/harbor-helm

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=harbor
export CHART_VERSION=1.14.2
export CORE_INGRESS_ADDRESS=core.example.com


kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Create a secret / stwórz sekret

```bash
# create tls certificate and create secret named harbor-cert / stwórz certyfikat tls  i stwórz secret o nazwie harbor-cert
kubectl -n ${K8S_NAMESPACE} create secret tls harbor-cert --cert=tls.crt --key=tls.key
```


## Installation via helm / Instalacja przy użyciu helm

```bash

helm upgrade --install harbor \
 -n ${CHART_NAMESPACE}  \
 -f https://raw.githubusercontent.com/sourcemation/charts/main/charts/harbor/${CHART_VERSION}/values \
 --set "expose.ingress.hosts.core=${CORE_INGRESS_ADDRESS}" \
 --repo https://helm.goharbor.io --version ${CHART_VERSION}
- 
