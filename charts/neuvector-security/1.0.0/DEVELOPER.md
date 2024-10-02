# For developers
 
## Installing from repo
 
```bash 
 
export CHART_VERSION=1.0.0
export CHART_NAMESPACE=cattle-neuvector-system
 
cd charts/charts/neuvector-security/${CHART_VERSION} 

 
helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \ 
neuvector-security .  
 
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} neuvector-security

```


# Testing

```bash

```
