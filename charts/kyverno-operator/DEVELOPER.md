# For developers
 
## Installing from repo
 
```bash
export RELEASE_NAME=kyverno
export CHART_NAME=kyverno-operator
export RELEASE_NAMESPACE=kyverno-operator

git clone git@github.com:Sourcemation/charts.git
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
