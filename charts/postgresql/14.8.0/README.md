# Useful links / Przydatne linki
- https://www.postgresql.org/
- https://github.com/postgres


# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export K8S_NAMESPACE=<namespace name>
export CHART_VERSION=14.8.0
export POSTGRESQL_NAME='postgresql'
export POSTGRESQL_USER='user'
export POSTGRESQL_PASS=$(openssl rand -hex 10)
export POSTGRESQL_DATABASE='mydatabase'

kubectl create ns ${K8S_NAMESPACE}
kubectl config set-context --current --namespace ${K8S_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm

```bash
helm upgrade --install ${POSTGRESQL_NAME}\
 -n ${K8S_NAMESPACE} \
 --set postgresql.postgresUser=${POSTGRESQL_USER} \
 --set postgresql.postgresPassword=${POSTGRESQL_PASS} \
 --set postgresql.postgresDB=${POSTGRESQL_DATABASE} \
 --repo https://sourcemation.github.io/charts/ ${POSTGRESQL_NAME} --version ${CHART_VERSION}
```

## Create test database / Stwórz baze testową

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Cluster
metadata:
  name: postgresql-test
  namespace: ${K8S_NAMESPACE}
spec:
  instances: 3
  storage:
    size: 1Gi
EOF

kubectl -n ${K8S_NAMESPACE} get po # check if pods are up / sprawdź czy pody działają
  
kubectl -n ${K8S_NAMESPACE} get cluster # check if cluster is present / sprawdź czy cluster został zainstalowany

```

## Check database connection \ Sprawdź czy można połączyć się z bazą

```bash
kubectl -n ${K8S_NAMESPACE} port-forward svc/postgresql-rw 5432:5432 &     # turn on port-frowarding / włącz port-frowarding
psql -p 5432 -h localhost -U  postgres    # connect to database / połącz  się do bazy
\l  # you should see database list / po tej komendzie powinna być widoczna lista baz
\q  # to exit client / żeby wyjść z klienta
fg  # to access process (port-froward) running in background, ctrl+c to stop it / żeby wyświetlić proces w tle (port-forward), ctrl+c żeby zakończyć proces
```
