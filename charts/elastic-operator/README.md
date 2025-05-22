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
export RELEASE_NAME=elk-operator
export CHART_NAME=elastic-operator
export RELEASE_NAMESPACE=lp-system
export CHART_VERSION=1.5.0

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}
```

### Go go helm

```bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
${CHART_NAME} --repo https://charts.sourcemation.com/ \
--version ${CHART_VERSION}
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
kubectl get validatingwebhookconfiguration -o name | grep -i open | xargs kubectl delete
kubectl get mutatingwebhookconfiguration -o name | grep -i open | xargs kubectl delete


#kubectl get crd -o name | grep -i istio | xargs kubectl delete
#kubectl get crd -o name | grep -i jaeger | xargs kubectl delete 
#kubectl get crd -o name | grep -i opentelemetry | xargs kubectl delete 
#kubectl get validatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete 
#kubectl get mutatingwebhookconfiguration -o name | grep -i istio | xargs kubectl delete
```
