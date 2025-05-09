## General

### Are you looking for more information?

1. Based on: https://github.com/OT-CONTAINER-KIT/redis-operator.git
2. Documentation: https://ot-redis-operator.netlify.app/docs/getting-started/sentinel/
3. Chart Source: https://github.com/OT-CONTAINER-KIT/redis-operator/tree/main/charts/redis-sentinel


## Before Installation

> **Note:**
> This chart requires redis-operator to be installed on current Kubernetes cluster


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

export CHART_NAMESPACE=redis
export CHART_VERSION=0.1.0

kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash
cat << EOF > /tmp/values.yaml

EOF 


helm -n ${CHART_NAMESPACE} upgrade --install redis-sentinel \
--repo https://charts.sourcemation.com/ \
redis-sentinel \
-f /tmp/values.yaml \
--version ${CHART_VERSION}

```

### Validation and Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po

```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall redis-sentinel

```

