## General

### Are you looking for more information?

1. Based on: https://github.com/cert-manager/cert-manager.git
2. Documentation: https://cert-manager.io/docs/
3. Chart Source: https://github.com/SourceMation/charts.git


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

  OR

#### Error: Unable to continue with install: CustomResourceDefinition "*.cert-manager.io" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "": current value is ""

Reason: cert-manager is installed in another namespace

Soloution:

1. Skip the operator's depthyment or if do not have cert-manager installed, just clean resources

```bash 
kubectl get crd -o name | grep -i cert-manager | xargs kubectl delete
```


## CLI installation

### Preparation

```bash

export RELEASE_NAMESPACE=cert-manager
export CHART_VERSION=1.0.0

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}

```

### Go go helm

``` bash
cat << EOF > /tmp/values.yaml

EOF 


helm -n ${RELEASE_NAMESPACE} upgrade --install example-chart \
--repo https://charts.sourcemation.com/ \
example-chart \
-f /tmp/values.yaml \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall cert-manager-operator
kubectl delete apiservice v1beta1.webhook.cert-manager.io
kubectl get crd -o name | grep -i cert-manager | xargs kubectl delete
```
