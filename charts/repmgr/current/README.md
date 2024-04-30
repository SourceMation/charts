# Useful links / Przydatne linki
- https://www.repmgr.org/
- https://artifacthub.io/packages/helm/bitnami/postgresql-ha

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE="repmgr"
export PSQL_USER="postgres_user"
export PSQL_PASSWORD="postgres_password"
export PSQL_DB="postgres_database"
export REPMGR_PASSWORD="repmgr_password"

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm -n ${CHART_NAMESPACE} upgrade --install postgresql-ha oci://registry-1.docker.io/bitnamicharts/postgresql-ha \
--set postgresql.username=${PSQL_USER} \
--set postgresql.password=${PSQL_PASSWORD} \
--set postgresql.database=${PSQL_DB} \
--set postgresql.repmgrPassword=${REPMGR_PASSWORD}
```