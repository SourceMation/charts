# For developers
 
## Installing from repo
 
```bash
export CHART_NAME=rabbitmq-operator
export CHART_NAMESPACE=lp-system

git clone git@github.com:SourceMation/charts.git
cd charts/charts/${CHART_NAME}

helm -n ${CHART_NAMESPACE} upgrade --install \
--create-namespace \ 
${CHART_NAME} .
``` 
# Cleaning

```bash
helm -n ${CHART_NAMESPACE} uninstall ${CHART_NAME}
kubectl get crd -o name | grep 'rabbitmq.com' | xargs kubectl delete
```

# Testing

```bash
helm -n ${CHART_NAMESPACE} test ${CHART_NAME}
```
