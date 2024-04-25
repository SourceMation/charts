# Useful links / Przydatne linki
- https://www.mongodb.com/
- https://github.com/mongodb/mongo


# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export K8S_NAMESPACE=<namespace name>
export CHART_VERSION=7.0.3
export MONGODB_NAME='mongodb'
export MONGODB_USER='root'
export MONGODB_PASS=$(openssl rand -hex 10)
export MONGODB_DATABASE='mydatabase'

kubectl create ns ${K8S_NAMESPACE}
kubectl config set-context --current --namespace ${K8S_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm

```bash
helm upgrade --install ${MONGODB_NAME} \
 -n ${K8S_NAMESPACE} \
 --set mongodb.username=${MONGODB_USER} \
 --set mongodb.password=${MONGODB_PASS} \
 --set mongodb.database=${MONGODB_DATABASE} \
 --repo https://sourcemation.github.io/charts/ ${MONGODB_NAME} --version ${CHART_VERSION}
```