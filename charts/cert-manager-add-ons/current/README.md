## General

### Are you looking for more information?

1. Based on: https://github.com/cert-manager/cert-manager.git

2. Documentation: 
* https://cert-manager.io/docs/
* https://github.com/nokia/adcs-issuer

3. Chart Source:
* https://github.com/nokia/adcs-issuer 


## Before Installation

1. Install Cert-manager (1/3) - Operator


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

#### Error: Unable to continue with install: CustomResourceDefinition "adcsissuers.adcs.certmanager.csf.nokia.com" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "cert-manager-add-ons": current value is "adcs-issuer"; annotation validation error: key "meta.helm.sh/release-namespace" must equal "cert-manager": current value is "adcs-issuer


Reason: cert-manager is installed in another namespace

Soloution:

1. Do not deploy Active Directory Certificate Services

2. If do not have Active Directory Certificate Services, just clean resources

```bash

helm -n adcs-issuer uninstall adcs-issuer

kubectl get crd -o name | grep -i adcs | xargs kubectl delete

```

> **Note:**
> Notify us: https://github.com/SourceMation/charts/issues


## CLI installation

### Preparation

```bash

export CHART_NAMESPACE=cert-manager
export CHART_VERSION=1.1.0

kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash

helm -n ${CHART_NAMESPACE} upgrade --install cert-manager-add-ons \
--repo https://sourcemation.github.io/charts/ \
cert-manager-add-ons /
--version ${CHART_VERSION}

```

### Validation and Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po
kubectl get ClusterAdcsIssuer,AdcsIssuer -A

```

## CLI removing

```bash


helm -n ${CHART_NAMESPACE} uninstall cert-manager-add-ons

kubectl get crd -o name | grep -i adcs | xargs kubectl delete


```
