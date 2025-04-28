## General

### Are you looking for more information?

1. Documentation: https://charts.bitnami.com/bitnami
2. Chart Source: https://github.com/SourceMation/charts.git

## Before Installation

> **Note:**
> no action required

## After Installation

> **Note:**
> no action required

## Before Upgrade

> **Note:**
> no action required

## After Upgrade

> **Note:**
> no action required

## Tips and Tricks

> **Note:**
> no tips and tricks

## Known Issues

> **Note:**
> Notify us: https://github.com/SourceMation/charts/issues

## CLI installation

### Preparation

```bash
export CHART_NAME=rabbitmq-cluster-operator
export CHART_VERSION=0.1.0
export CHART_NAMESPACE=lp-system

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}
```

### Go go helm

```bash
helm -n ${CHART_NAMESPACE} upgrade --install ${CHART_NAME} \
--repo https://sourcemation.github.io/charts/  ${CHART_NAME} \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${CHART_NAMESPACE} get all
helm -n ${CHART_NAMESPACE} test ${CHART_NAME}
```

## CLI removing

```bash
helm -n ${CHART_NAMESPACE} uninstall ${CHART_NAME}
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
