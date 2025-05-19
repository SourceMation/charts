# For developers
 
## Installing from repo
 
```bash 
git clone git@github.com:SourceMation/charts.git
cd charts/charts/neuvector

export CHART_NAMESPACE=neuvector

 
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
