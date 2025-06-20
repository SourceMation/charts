# For developers / Dla deweloperow 
 
## Installing from repo / Instalacja z repo  

```bash
export RELEASE_NAME=cert-manager-add-ons
export CHART_NAME=cert-manager-add-ons
export RELEASE_NAMESPACE=cert-manager
 
cd charts/charts/${CHART_NAME}

helm upgrade --install -n ${RELEASE_NAMESPACE} --create-namespace \
${RELEASE_NAME} .  
```

## Removing

```bash
helm uninstall -n ${RELEASE_NAMESPACE} ${RELEASE_NAME}
kubectl get crd -o name | grep -i adcs | xargs kubectl delete
```
