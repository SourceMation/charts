# For developers
 
## Installing from repo
 
```bash
export RELEASE_NAME=neuvector-sec
export CHART_NAME=neuvector-security
export RELEASE_NAMESPACE=lp-system

git clone git@github.com:SourceMation/charts.git
cd charts/charts/${CHART_NAME}

helm -n ${RELEASE_NAMESPACE} upgrade --install --create-namespace \
${RELEASE_NAME} .
``` 
# Cleaning

```bash
helm uninstall -n ${RELEASE_NAMESPACE} ${RELEASE_NAME}
```

# Testing

```bash

```
