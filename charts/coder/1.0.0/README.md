## General

### Are you looking for more information?

1. Based on: https://github.com/coder/coder.git
2. Documentation: https://coder.com/docs
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

export STACK_NAME=coder
export CHART_VERSION=1.0.0
export K8S_NAMESPACE=lp-app
export CODER_URL=coder.apps.example.com

kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash

helm -n ${K8S_NAMESPACE} upgrade --install ${STACK_NAME} \
--set "coder.coder.ingress.host=${CODER_URL}" \
--repo https://sourcemation.github.io/charts/ ${STACK_NAME} \
--version ${CHART_VERSION}

```

### Validation and Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po

```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall ${STACK_NAME}

```