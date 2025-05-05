## General

### Are you looking for more information?

1. Based on: https://github.com/kyverno/kyverno.git
2. Documentation: https://kyverno.io/docs/
3. Chart Source: https://github.com/SourceMation/charts.git

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
export CHART_NAMESPACE=kyverno
export CHART_VERSION=0.1.0
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace=${CHART_NAMESPACE}
```

### Go go helm

``` bash
helm -n ${CHART_NAMESPACE} upgrade --install kyverno \
--repo https://sourcemation.github.io/charts/ kyverno \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
helm -n ${CHART_NAMESPACE} test ${CHART_NAME}
```

## CLI removing

```bash
helm -n ${CHART_NAMESPACE} uninstall kyverno
```

