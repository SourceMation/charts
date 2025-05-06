# For developers
 
## Installing from repo
 
```bash 

export CHART_NAMESPACE=kyverno-operator
 
cd charts/charts/kyverno-operator/

helm  upgrade --install -n ${CHART_NAMESPACE} --create-namespace \
kyverno-operator .
 
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} kyverno-operator

```


# Testing

```bash

```
