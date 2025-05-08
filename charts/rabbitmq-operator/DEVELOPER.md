# For developers
 
## Installing from repo
 
```bash
git clone git@github.com:SourceMation/charts.git
cd charts/charts/rabbitmq-cluster-operator

export CHART_NAME=rabbitmq-operator
export CHART_NAMESPACE=lp-system

helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \ 
${CHART_NAME} .
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} ${CHART_NAME}
kubectl get crd -o name | grep 'rabbitmq.com' | xargs kubectl delete
```


# Testing

```bash
helm test -n ${CHART_NAMESPACE} ${CHART_NAME}
```
