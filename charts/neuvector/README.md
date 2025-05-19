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
export CHART_NAMESPACE=neuvector
export CHART_VERSION=0.1.0

kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}
```

### Go go helm

``` bash
cat << EOF > /tmp/values.yaml

EOF 


helm -n ${CHART_NAMESPACE} upgrade --install neuvector \
--repo https://charts.sourcemation.com/ \
neuvector \
-f /tmp/values.yaml \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
helm -n ${CHART_NAMESPACE} test neuvector
```

## CLI removing

```bash
helm -n ${CHART_NAMESPACE} uninstall neuvector
```
