# Useful links / Przydatne linki
- https://www.pgadmin.org/
- https://github.com/pgadmin-org/pgadmin4

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export RELEASE_NAMESPACE=pgadmin
export PGADMIN_DEFAULT_EMAIL="user@example.com"
export PGADMIN_DEFAULT_PASSWORD="SecretPassword"
export PGADMIN_HOST_URL="pgadmin.example.com"

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace=${RELEASE_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm

```bash
helm -n ${RELEASE_NAMESPACE} upgrade --install --create-namespace \
pgadmin charts/pgadmin/ \
--set env.PGADMIN_DEFAULT_EMAIL=${PGADMIN_DEFAULT_EMAIL} \
--set env.PGADMIN_DEFAULT_PASSWORD=${PGADMIN_DEFAULT_PASSWORD} \
--set env.PGADMIN_HOST_URL=${PGADMIN_HOST_URL}
```
