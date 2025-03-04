# For developers
 
## Installing from repo
 
```bash 
 
export CHART_VERSION=1.0.0
export CHART_NAMESPACE=cngp
 
cd charts/charts/cngp/${CHART_VERSION} 

 
helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \ 
cngp .  
 
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} cngp

```


# Testing

```bash

```
