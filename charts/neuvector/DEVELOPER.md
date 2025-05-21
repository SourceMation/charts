# For developers
 
## Installing from repo
 
```bash
export RELEASE_NAME=neuvector
export CHART_NAME=neuvector
export RELEASE_NAMESPACE=neuvector

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
kubectl -n ${RELEASE_NAMESPACE} get po
```
