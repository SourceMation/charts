# For developers
 
## Installing from repo
 
```bash 

export CHART_NAMESPACE=kyverno
 
cd charts/charts/kyverno/

helm  upgrade --install -n ${CHART_NAMESPACE} --create-namespace \
kyverno .
 
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} kyverno

```


# Testing

```bash

```
