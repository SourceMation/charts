# For developers
 
## Installing from repo
 
```bash
export RELEASE_NAME=cnpg-operator
export CHART_NAME=cnpg-operator
export CHART_NAME=cnpg-operator
export RELEASE_NAMESPACE=lp-system
 
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
