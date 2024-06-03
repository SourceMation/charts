# Useful links / Przydatne linki
- https://www.pgpool.net/
- https://github.com/pgpool/pgpool2
- https://github.com/pgpool/pgpool2_on_k8s

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=pgpool
export PGPOOL_PARAMS_BACKEND_HOSTNAME0="primary_hostname"
export PGPOOL_PARAMS_BACKEND_FLAG0="ALWAYS_PRIMARY|DISALLOW_TO_FAILOVER"
export PGPOOL_PARAMS_BACKEND_HOSTNAME1="replica_hostname"
export PGPOOL_PARAMS_BACKEND_FLAG1="DISALLOW_TO_FAILOVER"
export POSTGRES_USERNAME="postgres_user"
export POSTGRES_PASSWORD="postgres_pass"

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm -n ${CHART_NAMESPACE} upgrade --install --create-namespace pgpool charts/pgpool/1.0.0/ \
--set env.PGPOOL_PARAMS_BACKEND_HOSTNAME0=${PGPOOL_PARAMS_BACKEND_HOSTNAME0} \
--set env.PGPOOL_PARAMS_BACKEND_HOSTNAME1=${PGPOOL_PARAMS_BACKEND_HOSTNAME1} \
--set env.PGPOOL_PARAMS_BACKEND_FLAG0=${PGPOOL_PARAMS_BACKEND_FLAG0} \
--set env.PGPOOL_PARAMS_BACKEND_FLAG1=${PGPOOL_PARAMS_BACKEND_FLAG1} \
--set env.PGPOOL_PARAMS_FAILOVER_ON_BACKEND_ERROR=${PGPOOL_PARAMS_FAILOVER_ON_BACKEND_ERROR} \
--set env.POSTGRES_USERNAME=${POSTGRES_USERNAME} \
--set env.POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
```
