## General

### Are you looking for more information?

1. Based on: https://github.com/tektoncd
2. Documentation: https://tekton.dev/docs/
3. Chart Source: https://github.com/SourceMation/charts.git


## Before Installation

The installation of cert-manager is required according to the instructions provided in the README file of the latest version: https://github.com/SourceMation/charts/tree/main/charts/cert-manager

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

export STACK_NAME=tekton
export CHART_VERSION=1.0.0
export CHART_URL=tekton.apps.example.com
export CERT_SECRET_NAME=default-secret-name
export INSTALL_TEKTON_OPERATOR=true

```

### Go go helm

``` bash

helm upgrade --install ${STACK_NAME} \
--set "global.tektonOperator.enabled=${INSTALL_TEKTON_OPERATOR}" \
--set "tekton.dashboard.ingress.host=${CHART_URL}" \
--set "tekton.webhook.secretName=${CERT_SECRET_NAME}" \
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