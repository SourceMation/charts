## General

### Are you looking for more information?

1. Based on: https://github.com/neuvector/neuvector.git 
2. Documentation: https://open-docs.neuvector.com/
3. Chart Source: https://github.com/neuvector/neuvector-helm/tree/master/charts/core


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
export RELEASE_NAME=neuvector
export CHART_NAME=neuvector
export RELEASE_NAMESPACE=neuvector
export CHART_VERSION=0.1.3

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}
```

### Go go helm

``` bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
${CHART_NAME} --repo https://charts.sourcemation.com/ \
-f /tmp/values.yaml \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po
helm -n ${RELEASE_NAMESPACE} test ${RELEASE_NAME}
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
```
