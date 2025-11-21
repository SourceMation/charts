## General

### Are you looking for more information?

1. Based on: https://github.com/strimzi/strimzi-kafka-operator.git
2. Documentation: https://strimzi.io/documentation/
3. Chart Source: https://github.com/strimzi/strimzi-kafka-operator/tree/main/helm-charts/helm3/strimzi-kafka-operator


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
> Notify us: https://github.com/Sourcemation/charts/issues



## CLI installation

### Preparation

```bash
export RELEASE_NAME=kafka
export CHART_NAME=strimzi-kafka-operator
export RELEASE_NAMESPACE=lp-system
export CHART_VERSION=0.1.4

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}
```

### Go go helm

``` bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
${CHART_NAME} --repo https://charts.sourcemation.com/ \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
kubectl get crd -o name | grep -i strimzi | xargs kubectl delete
```
