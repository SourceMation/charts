# For developers
 
## Installing from repo
 
```bash 
 
export CHART_NAMESPACE=neuvector
 
cd charts/charts/neuvector 

 
helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \ 
neuvector .  
 
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} neuvector

```


# Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
```
