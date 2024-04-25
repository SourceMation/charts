# Useful links / Przydatne linki
- https://www.pgbouncer.org/
- https://github.com/bitnami/containers/tree/main/bitnami/pgbouncer

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=pgpool
export POSTGRESQL_HOST="psql1"
export POSTGRESQL_PASSWORD="SecurePassword"
export POSTGRESQL_DATABASE="psql_database"
export PGBOUNCER_AUTH_TYPE="trust"
export PGBOUNCER_DSN_0="pg0=host=pg1 port=5432 dbname=db1"
export PGBOUNCER_DSN_1="pg1=host=pg1 port=5432 dbname=db1"
export PGBOUNCER_DSN_2="pg2=host=pg1 port=5432 dbname=db1"
```
Add another PGBOUNCER_DSN_X if needed
```bash
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```
## Configuration of the needed configmap / Konfiguracja potrzebnej configmapy
Complete the command below with the appropriate data and execute

```
kubectl apply -f configmap.yaml - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: pgbouncer-userlist
data:
  userlist.txt: |
    "postgres" "password1"
    "postgres" "password2"
    "postgres" "password3"
EOF
```
## Installation via helm / Instalacja przy użyciu helm
Edit the command below accordingly if you used a different PGBOUNCER_DSN number

```bash
helm -n ${CHART_NAMESPACE} upgrade --install --create-namespace pgbouncer charts/pgbouncer/1.0.0/ \
--set env.POSTGRESQL_HOST=${POSTGRESQL_HOST} \
--set env.POSTGRESQL_PASSWORD=${POSTGRESQL_PASSWORD} \
--set env.POSTGRESQL_DATABASE=${POSTGRESQL_DATABASE} \
--set env.PGBOUNCER_AUTH_TYPE=${PGBOUNCER_AUTH_TYPE} \
--set env.PGBOUNCER_DSN_0="${PGBOUNCER_DSN_0}" \
--set env.PGBOUNCER_DSN_1="${PGBOUNCER_DSN_1}" \
--set env.PGBOUNCER_DSN_2="${PGBOUNCER_DSN_2}"
```
