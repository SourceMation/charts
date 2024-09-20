# Useful links / Przydatne linki

- https://istio.io
- https://github.com/rancher/charts

# Supprted versions

Kubernetes: 1.26-1.30


# Installation / Instalacja

## Preparation / Przygotowanie

```bash

export CHART_NAMESPACE=lp-system
export CHART_VERSION=1.3.0

kubectl create ns ${CHART_NAMESPACE}

```

## Installation via helm / Instalacja przy użyciu helm

``` bash

helm -n ${CHART_NAMESPACE} upgrade --install monitoring-stack-crd \
--repo https://sourcemation.github.io/charts/ \
--version ${CHART_VERSION}

```

# Remove / Usuwanie

```bash

helm -n ${CHART_NAMESPACE} uninstall monitoring-stack-crd
kubectl get crd -o name | grep -i istio | xargs kubectl delete
kubectl get crd -o name | grep -i jaeger | xargs kubectl delete 
kubectl get crd -o name | grep -i opentelemetry | xargs kubectl delete 
kubectl get validatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete 
kubectl get mutatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete

kubectl get validatingwebhookconfiguration -o name | grep -i open | xargs kubectl delete
kubectl get mutatingwebhookconfiguration -o name | grep -i open | xargs kubectl delete

```

# For developers / Dla deweloperow

## Installing from repo / Instalacja z repo

```bash

export CHART_VERSION=1.3.0
export CHART_NAMESPACE=lp-system

cd charts/monitoring-stack-crd/${CHART_VERSION}


helm -n ${CHART_NAMESPACE} upgrade --install -n ${CHART_NAMESPACE} --create-namespace \
monitoring-stack-crd . 

```

