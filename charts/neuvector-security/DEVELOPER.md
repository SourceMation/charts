# For developers
 
## Installing from repo
 
```bash 
git clone git@github.com:SourceMation/charts.git
cd charts/charts/neuvector-security/

export CHART_NAMESPACE=cattle-neuvector-system
 
helm -n ${CHART_NAMESPACE} upgrade --install neuvector-security \
--create-namespace .  
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} neuvector-security
```

# Testing

```bash

```
