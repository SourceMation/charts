## General

### Are you looking for more information?

1. Based on: https://github.com/goharbor/harbor-helm
2. Documentation: https://goharbor.io/docs/2.11.0/
3. Chart Source: https://github.com/SourceMation/charts/tree/main/charts/harbor


## Before Installation


> **Note:**
> no action required

OR
1. Install following charts

```bash 

helm upgrade install ...

```

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

export CHART_NAMESPACE=harbor

kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash
cat << EOF > /tmp/values.yaml

EOF 


helm -n ${CHART_NAMESPACE} upgrade --install harbor \
--repo https://sourcemation.github.io/charts/ \
harbor \
-f /tmp/values.yaml

```

### Validation and Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po

```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall harbor

kubectl -n ${CHART_NAMESPACE} get pvc | sed -n '/harbor/s/ .*//p' | xargs kubectl delete pvc -n ${CHART_NAMESPACE}

```

