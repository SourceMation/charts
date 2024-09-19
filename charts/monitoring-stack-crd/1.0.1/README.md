# Useful links / Przydatne linki

- https://istio.io
- https://github.com/rancher/charts

# Installation / Instalacja

## Preparation / Przygotowanie

```bash

export CHART_NAMESPACE=lp-system
export CHART_VERSION=1.0.1

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

# For developers

## Debug chart
```bash

export CHART_VERSION=1.0.1
export CHART_NAMESPACE=lp-system

cd charts/monitoring-stack-crd/${CHART_VERSION}


cat <<EOF> /tmp/monitoring-stack-crd.yaml
global:
  elasticCrd:
    enabled: false
  istioCrd:
    enabled: false
EOF


helm -n ${CHART_NAMESPACE} upgrade --install --create-namespace monitoring-stack-crd . \
-f /tmp/monitoring-stack-crd.yaml

```

## Deploy example istio app

```bash 

kubectl create ns example-istio
kubectl label namespace example-istio istio-injection=enabled

kubectl -n example-istio apply -f https://raw.githubusercontent.com/istio/istio/1.22.1/samples/bookinfo/platform/kube/bookinfo.yaml 


kubectl -n example-istio rollout restart deploy details-v1 productpage-v1 ratings-v1 reviews-v1 reviews-v2 reviews-v3

kubectl -n example-istio get po 

kubectl -n example-istio exec "$(kubectl -n example-istio get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"


kubectl -n example-istio exec "$(kubectl -n example-istio get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- /bin/bash -c 'for i in $(seq 1 100); do curl -s -o /dev/null "http://productpage:9080/productpage"; done' 

kubectl delete ns example-istio

#

```
