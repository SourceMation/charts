# For developers
 
## Installing from repo
 
```bash 
 
export CHART_NAMESPACE=lp-system
 
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
kubectl -n ${CHART_NAMESPACE} get po
```
