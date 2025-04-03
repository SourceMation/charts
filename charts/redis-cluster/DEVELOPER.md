# For developers
 
## Installing from repo
 
```bash 
 
export CHART_NAMESPACE=redis
 
cd charts/charts/redis-cluster

 
helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \
redis-cluster .  
 
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} redis-cluster

```


# Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
```
