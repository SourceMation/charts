## General

### Are you looking for more information?

1. Based on: https://github.com/istio/istio.git
2. Documentation: https://istio.io/latest/docs/
3. Chart Source: https://github.com/istio/istio/tree/master/manifests/charts/base


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

#### Error: rendered manifests contain a resource that already exists. Unable to continue with install: ServiceAccount "istio-reader-service-account" in namespace "istio-system" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "aaaaa": current value is "bbbbb"

Reason: istio is installed in another namespace

Soloution:

1. Skip the operator's deployment or if do not have istio installed, just clean resources

```bash

kubectl get crd -o name | grep -i istio | xargs kubectl delete

```

## CLI installation

### Preparation

```bash

export CHART_NAMESPACE=istio-system
export CHART_VERSION=0.1.0

kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash
cat << EOF > /tmp/values.yaml

EOF 


helm -n ${CHART_NAMESPACE} upgrade --install istio-operator \
--repo https://sourcemation.github.io/charts/ \
istio-operator \
-f /tmp/values.yaml \
--version ${CHART_VERSION}

```

### Validation and Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po

```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall istio-operator

kubectl get crd -o name | grep -i istio | xargs kubectl delete


```

