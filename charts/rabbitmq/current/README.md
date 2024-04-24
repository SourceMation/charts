# Useful links / Przydatne linki
- https://www.rabbitmq.com/
- https://github.com/rabbitmq


# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export K8S_NAMESPACE=<namespace name>
export CHART_VERSION=3.11.10
export RABBITMQ_NAME='rabbitmq'
export RABBITMQ_USER='admin'
export RABBITMQ_PASS='admin'

kubectl create ns ${K8S_NAMESPACE}
kubectl config set-context --current --namespace ${K8S_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm

```bash
 helm upgrade --install ${RABBITMQ_NAME} \
-n ${K8S_NAMESPACE} \
--repo https://sourcemation.github.io/charts/ \
--set rabbitmq.username=${RABBITMQ_USER} \
--set rabbitmq.password=${RABBITMQ_PASS} \
${RABBITMQ_NAME} --version ${CHART_VERSION}
```