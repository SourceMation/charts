## Generic

Based on: https://github.com/elastic/cloud-on-k8s.git
Doc: https://www.elastic.co/guide/en/cloud-on-k8s/current/index.html
Source: https://github.com/SourceMation/charts.git

## Requirements

lack of informations

## Before Installation

no action required

## After Installation

no action required

## Before Upgrade

no action required

## After Upgrade

no action required


## Known Issues

lack of known issues




## CLI installation

### Preparation

```bash

export CHART_NAMESPACE=lp-system
export CHART_VERSION=1.4.0

kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash

helm -n ${CHART_NAMESPACE} upgrade --install elastic-operator \
--repo https://sourcemation.github.io/charts/ \
--version ${CHART_VERSION}

```


## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall elastic-operator

kubectl get validatingwebhookconfiguration -o name | grep -i open | xargs kubectl delete
kubectl get mutatingwebhookconfiguration -o name | grep -i open | xargs kubectl delete


#kubectl get crd -o name | grep -i istio | xargs kubectl delete
#kubectl get crd -o name | grep -i jaeger | xargs kubectl delete 
#kubectl get crd -o name | grep -i opentelemetry | xargs kubectl delete 
#kubectl get validatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete 
#kubectl get mutatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete

```

