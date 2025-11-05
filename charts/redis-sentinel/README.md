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
> Notify us: https://github.com/Sourcemation/charts/issues


## CLI installation

### Preparation

```bash
export RELEASE_NAME=redis-sentinel
export CHART_NAME=redis-sentinel
export RELEASE_NAMESPACE=redis
export CHART_VERSION=0.1.2

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
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
```
