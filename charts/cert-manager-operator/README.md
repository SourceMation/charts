## General

### Are you looking for more information?

1. Based on: https://github.com/cert-manager/cert-manager.git
2. Documentation: https://cert-manager.io/docs/
3. Chart Source: https://github.com/Sourcemation/charts.git


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

#### Error: Unable to continue with install: CustomResourceDefinition "*.cert-manager.io" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "": current value is ""

Reason: cert-manager is installed in another namespace

Soloution:

1. Do not deploy this operator

2. If do not have cert-manager, just clean resources

```bash 
kubectl get crd -o name | grep -i cert-manager | xargs kubectl delete
```

#### Internal error occurred: failed calling webhook "webhook.cert-manager.io": failed to call webhook: Post "": no endpoints available for service "cert-manager-webhook"

Reason:

1. cert-manager do not start on time

Solution:

1. Re-deploy installation 


## CLI installation

### Preparation

```bash
export RELEASE_NAME=cert-manager-operator
export CHART_NAME=cert-manager-operator
export RELEASE_NAMESPACE=cert-manager
export CHART_VERSION=1.1.0

kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}
```

### Go go helm

``` bash
helm -n ${RELEASE_NAMESPACE} upgrade --install ${RELEASE_NAME} \
${CHART_NAME} --repo https://charts.sourcemation.com/ \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${RELEASE_NAMESPACE} get po
kubectl get issuers,clusterissuers,certificates,certificaterequests,orders,challenges -A
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
kubectl delete apiservice v1beta1.webhook.cert-manager.io
kubectl get crd -o name | grep -i cert-manager | xargs kubectl delete
kubectl -n ${RELEASE_NAMESPACE} delete secret/trust-manager-tls
```
