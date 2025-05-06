# For developers
 
## Installing from repo
 
```bash
git clone git@github.com:SourceMation/charts.git
cd charts/charts/rabbitmq-cluster-operator

export CHART_NAME=rabbitmq-cluster-operator
export CHART_VERSION=0.1.0
export CHART_NAMESPACE=lp-system

helm upgrade --install -n ${CHART_NAMESPACE} --create-namespace \ 
${CHART_NAME} .
``` 
# Cleaning

```bash
helm uninstall -n ${CHART_NAMESPACE} ${CHART_NAME}
kubectl delete \
  crd/bindings.rabbitmq.com \
  crd/exchanges.rabbitmq.com \
  crd/federations.rabbitmq.com \
  crd/operatorpolicies.rabbitmq.com \
  crd/permissions.rabbitmq.com \
  crd/policies.rabbitmq.com \
  crd/queues.rabbitmq.com \
  crd/rabbitmqclusters.rabbitmq.com \
  crd/schemareplications.rabbitmq.com \
  crd/shovels.rabbitmq.com \
  crd/superstreams.rabbitmq.com \
  crd/topicpermissions.rabbitmq.com \
  crd/users.rabbitmq.com \
  crd/vhosts.rabbitmq.com
```


# Testing

```bash
helm test -n ${CHART_NAMESPACE} ${CHART_NAME}
```
