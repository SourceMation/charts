# For developers
 
## Installing from repo
 
```bash 
git clone git@github.com:SourceMation/charts.git
cd charts/charts/redis-sentinel

export CHART_NAMESPACE=redis
 
helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \
redis-sentinel .  
``` 

# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} redis-sentinel
```


# Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
```
