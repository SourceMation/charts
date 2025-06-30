# For developers
 
## Installing from repo
 
```bash
export RELEASE_NAME=redis-cluster
export CHART_NAME=redis-cluster
export RELEASE_NAMESPACE=redis

git clone git@github.com:SourceMation/charts.git
cd charts/charts/${CHART_NAME}

helm upgrade --install -n ${RELEASE_NAMESPACE} --create-namespace \
${RELEASE_NAME} .
``` 

# Cleaning

```bash
helm uninstall -n ${RELEASE_NAMESPACE} ${RELEASE_NAME}
```

# Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po
```
