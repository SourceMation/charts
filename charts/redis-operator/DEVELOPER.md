# For developers
 
## Installing from repo
 
```bash 
git clone git@github.com:SourceMation/charts.git
cd charts/charts/redis-operator

export CHART_NAMESPACE=lp-system
 
helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \
redis-operator .
``` 

# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} redis-operator
```


# Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
```
