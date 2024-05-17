# Useful links / Przydatne linki
- https://github.com/2ndQuadrant/pglogical
- https://www.2ndquadrant.com/en/resources-old/pglogical/pglogical-docs/

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE="pglogical"
export POSTGRES_PASSWORD="<postgres-password>"
export DB_USER="<database_user>"
export DB_PASS="<database_user_password>"
export DB_NAME="<database>"
export SUBSCRIPTION_NAME="<name_of_subscription>"
export STORAGE_CLASS="<name_of_storageclass>"
export STORAGE_SIZE="<size_of_storage>"


kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm -n ${CHART_NAMESPACE} upgrade --install --create-namespace pglogical charts/pglogical/1.0.0/ \
--set env.POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
--set env.DB_USER=${DB_USER} \
--set env.DB_PASS=${DB_PASS} \
--set env.DB_NAME=${DB_NAME} \
--set env.SUBSCRIPTION_NAME=${SUBSCRIPTION_NAME} \
--set volumeClaimTemplates.storageClassName=${STORAGE_CLASS} \
--set volumeClaimTemplates.storageSize=${STORAGE_SIZE} 
```

## Post-installation configuration - first run / Konfiguracja poinstalacyjna - pierwsze uruchomienie
### Verification / Weryfikacja
```bash
kubectl -n ${CHART_NAMESPACE} get pod | grep pglogical
pglogical-0                             1/1     Running   0          6m24s
pglogical-1                             1/1     Running   0          6m18s

kubectl -n ${CHART_NAMESPACE} get statefulset | grep pglogical
pglogical                  2/2     7m23s

kubectl -n ${CHART_NAMESPACE} get services | grep pglogical
pglogical-0                         ClusterIP   10.43.60.103    <none>        5432/TCP   8m19s
pglogical-1                         ClusterIP   10.43.41.113    <none>        5432/TCP   8m19s
```

### Preparing the primary node / Przygotowanie głównego node'a
```bash
kubectl exec -n ${CHART_NAMESPACE} -it pglogical-0 -- /bin/bash -c "/script_primary.sh"
```

#### Example output / Przykładowy wynik
``` bash
ALTER ROLE
GRANT
CREATE EXTENSION
 create_node
-------------
  2919861604
(1 row)

 replication_set_add_all_tables
--------------------------------
 t
(1 row)
```
### Preparing the remaining nodes / Przygotowanie pozostałych nodów
```bash
kubectl exec -n ${CHART_NAMESPACE} -it pglogical-1 -- /bin/bash -c "/script_secondary.sh"
```
#### Example output / Przykładowy wynik
``` bash
ALTER ROLE
GRANT
CREATE EXTENSION
 create_node
-------------
  2962617676
(1 row)

 create_subscription
---------------------
          1771415073
(1 row)

 wait_for_subscription_sync_complete
-------------------------------------

(1 row)
```
#### Additional information / Dodatkowe informacje

In the case of a larger number of replicas, repeat the "Preparing the remaining nodes" step, changing the name of the pglogical-1 pod to the name of the next one that is to become a replica.

W przypadku większej ilości replik należy powtórzyć krok "Przygotowanie pozostałych nodów" zmieniając nazwę poda pglogical-1 na nazwę kolejnego, który ma zostać repliką. 