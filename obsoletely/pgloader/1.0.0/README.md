# Useful links / Przydatne linki
- https://pgloader.io/
- https://github.com/dimitri/pgloader
- https://pgloader.readthedocs.io/en/latest/install.html

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE="pgloader"
export MYDB_HOSTNAME="mysql_host"
export PGDB_HOSTNAME="psql_host"
export MYDB_USER="mysql_user"
export PGDB_USER="psql_user"
export MYDB_PASSWORD="mysql_password"
export PGDB_PASSWORD="postgres_password"

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm -n ${CHART_NAMESPACE} upgrade --install --create-namespace pgloader charts/pgloader/1.0.0/ \
--set env.MYDB_HOSTNAME=${MYDB_HOSTNAME} \
--set env.MYDB_USER=${MYDB_USER} \
--set env.MYDB_PASSWORD=${MYDB_PASSWORD} \
--set env.PGDB_HOSTNAME=${PGDB_HOSTNAME} \
--set env.PGDB_USER=${PGDB_USER} \
--set env.PGDB_PASSWORD=${PGDB_PASSWORD} 
```
