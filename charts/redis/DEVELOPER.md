# For developers
 
## Installing from repo
 
```bash 
 
export CHART_NAMESPACE=redis
 
cd charts/charts/redis

 
helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \
redis .  
 
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} redis

```


# Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
```
