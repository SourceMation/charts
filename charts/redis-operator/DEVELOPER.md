# For developers
 
## Installing from repo
 
```bash 
 
export CHART_NAMESPACE=lp-system
 
cd charts/charts/redis-operator

 
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
