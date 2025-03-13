# For developers
 
## Installing from repo
 
```bash 
 
export CHART_VERSION=0.1.0
export CHART_NAMESPACE=lp-system
 
cd charts/charts/istio-operator 

helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \
istio-operator .

``` 
# Cleaning

```bash

helm uninstall -n ${CHART_NAMESPACE} istio-operator

```


# Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po

```
