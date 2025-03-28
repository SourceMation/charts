# For developers
 
## Installing from repo
 
```bash 
 
export CHART_VERSION=0.1.0
export CHART_NAMESPACE=lp-system
 
cd charts/charts/istio

helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \
istio .

``` 
# Cleaning

```bash

helm uninstall -n ${CHART_NAMESPACE} istio
kubectl get crd -o name | grep -i istio | xargs kubectl delete

```


# Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po

```
