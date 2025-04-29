# For developers
 
## Installing from repo
 
```bash 
 
export CHART_NAMESPACE=redis
 
cd charts/charts/redis-sentinel

 
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
