# Useful links / Przydatne linki
- https://redis.io/
- https://github.com/redis/redis


# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export K8S_NAMESPACE=<namespace name>
export CHART_VERSION=6.2.7
export REDIS_NAME='redis'
export REDIS_PASS=$(openssl rand -hex 10)

kubectl create ns ${K8S_NAMESPACE}
kubectl config set-context --current --namespace ${K8S_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm

```bash
helm upgrade --install ${REDIS_NAME} \
 -n ${K8S_NAMESPACE} \
 --set redis.password=${REDIS_PASS} \
 --repo https://sourcemation.github.io/charts/ ${REDIS_NAME} --version ${CHART_VERSION}
```