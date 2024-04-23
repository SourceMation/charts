# Useful links / Przydatne linki
- https://www.rabbitmq.com/
- https://github.com/rabbitmq


# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export K8S_NAMESPACE=<namespace name>
export CHART_VERSION=3.11.10
export RABBITMQ_NAME='rabbitmq'

kubectl create ns ${K8S_NAMESPACE}
kubectl config set-context --current --namespace ${K8S_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm

```bash
helm upgrade --install ${RABBITMQ_NAME} \
 -n ${K8S_NAMESPACE} \
 --repo https://raw.githubusercontent.com/sourcemation/charts/main/docs
 ${RABBITMQ_NAME} --version ${CHART_VERSION}
```