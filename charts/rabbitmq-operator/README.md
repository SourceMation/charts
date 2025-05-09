## General

### Are you looking for more information?

1. Documentation: https://www.rabbitmq.com/kubernetes/operator/install-operator
2. Chart Source: https://github.com/bitnami/charts/tree/main/bitnami/rabbitmq-cluster-operator

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
export CHART_NAME=rabbitmq-operator
export CHART_VERSION=0.1.0
export CHART_NAMESPACE=lp-system

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}
```

### Go go helm

```bash
helm -n ${CHART_NAMESPACE} upgrade --install ${CHART_NAME} \
--repo https://charts.sourcemation.com/  ${CHART_NAME} \
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
kubectl get crd -o name | grep 'rabbitmq.com' | xargs kubectl delete
```
