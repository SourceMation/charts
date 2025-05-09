## General

### Are you looking for more information?

1. Based on: https://github.com/cert-manager/cert-manager.git

2. Documentation: 
* https://cert-manager.io/docs/
* https://github.com/nokia/adcs-issuer

3. Chart Source:
* https://github.com/nokia/adcs-issuer 


## Before Installation

1. Install chart via Apps: Cert-manager (1/3) - Operator
2. Install chart via Apps: Cert-manager (2/3) - Add-ons


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

export CHART_NAMESPACE=cert-manager
export CHART_VERSION=1.1.0

kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash

helm -n ${CHART_NAMESPACE} upgrade --install cert-manager \
--repo https://charts.sourcemation.com/ \
default-issuer /
--version ${CHART_VERSION}

```

### Validation and Testing

```bash

kubectl get clusterissuer,issuer,clusteradcsissuer,adcsissuer,cert,crp -A

```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall default-issuer

```
