# Useful links / Przydatne linki
- https://github.com/coder/coder/tree/main/helm/coder
- https://coder.com/docs/v2/latest/install/kubernetes


# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=coder
export CHART_VERSION=2.10.0
export CODER_USER=coder
export CODER_PASSWORD=$(openssl rand -hex 10)
export CODER_DATABASE=coderi
export CODER_URL=example.com

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Install PostgreSQL / Zainstaluj Postgresql

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo update

helm install coder-db bitnami/postgresql \
 -n ${CHART_NAMESPACE} \
 --set auth.username=${CODER_USER} \
 --set auth.password=${CODER_PASSWORD} \
 --set auth.database=${CODER_DATABASE} \
 --set persistence.size=10Gi
```

## Create secret with db url / Stwórz secret z db url

```bash
kubectl create secret generic coder-db-url -n ${CHART_NAMESPACE} \
   --from-literal=url="postgres://${CODER_USER}:${CODER_PASSWORD}@coder-db-postgresql.${CHART_NAMESPACE}.svc.cluster.local:5432/${CODER_DATABASE}?sslmode=disable"
```

## Installation via helm / Instalacja przy użyciu helm

```bash
helm upgrade --install coder \
 -n ${CHART_NAMESPACE} \
 --set "coder.env.name[0].value=${CODER_URL}
 -f https://raw.githubusercontent.com/sourcemation/charts/main/charts/coder/${CHART_VERSION}/values \
 --repo https://helm.coder.com/v2 coder --version ${CHART_VERSION}
```
