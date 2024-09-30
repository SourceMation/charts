# For developers
 
## Installing from repo
 
```bash 
 
export CHART_VERSION=1.0.0
export CHART_NAMESPACE=example-chart
 
cd charts/charts/example-chart/${CHART_VERSION} 

 
helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \ 
example-chart .  
 
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} example-chart

```


# Testing

```bash

```
