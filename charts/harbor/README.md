# Useful links / Przydatne linki
- https://goharbor.io/docs/
- https://github.com/goharbor/harbor-helm

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export RELEASE_NAME=harbor
export CHART_NAME=harbor
export RELEASE_NAMESPACE=harbor
export CHART_VERSION=1.14.2
export CORE_INGRESS_ADDRESS=core.example.com


kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace=${RELEASE_NAMESPACE}
```

## Create a secret / stwórz sekret

```bash
# create tls certificate and create secret named harbor-cert / stwórz certyfikat tls  i stwórz secret o nazwie harbor-cert
kubectl -n ${RELEASE_NAMESPACE} create secret tls harbor-cert --cert=tls.crt --key=tls.key
```


## Installation via helm / Instalacja przy użyciu helm

```bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
--set "expose.ingress.hosts.core=${CORE_INGRESS_ADDRESS}" \
${CHART_NAME} --repo https://helm.goharbor.io \
-f https://raw.githubusercontent.com/sourcemation/charts/main/charts/harbor/values \
--version ${CHART_VERSION}
```
