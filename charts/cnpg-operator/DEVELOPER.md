# For developers
 
## Installing from repo
 
```bash 
 
export CHART_VERSION=1.0.0
export CHART_NAMESPACE=cngp-operator
 
cd charts/charts/cnpg-operator 

 
helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \ 
cnpg-operator .  
 
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} cnpg-operator

```


# Testing

```bash

```
