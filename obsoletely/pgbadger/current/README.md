# Useful links / Przydatne linki
- https://github.com/darold/pgbadger

# Installation / Instalacja
## Preparation /Przygotowanie

```bash
export CHART_NAMESPACE=pgbadger

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

## Installation via helm / Instalacja przy użyciu helm
```bash
helm -n ${CHART_NAMESPACE} upgrade --install --create-namespace pgadmin charts/pgbadger/1.0.0/
```
