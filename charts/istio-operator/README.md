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
export RELEASE_NAME=istio
export CHART_NAME=istio-operator
export RELEASE_NAMESPACE=istio-system
export CHART_VERSION=0.2.1

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}

cat << EOF > /tmp/values.yaml
global:
    istioNamespace: $RELEASE_NAMESPACE
EOF
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
kubectl get crd -o name | grep -i istio | xargs kubectl delete
```
