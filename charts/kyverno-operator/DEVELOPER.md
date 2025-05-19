# For developers
 
## Installing from repo
 
```bash
git clone git@github.com:SourceMation/charts.git
cd charts/charts/kyverno-operator/

export CHART_NAMESPACE=kyverno-operator

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
