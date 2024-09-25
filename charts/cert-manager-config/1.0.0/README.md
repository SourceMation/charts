## Generic

Based on: https://github.com/cert-manager/cert-manager.git
Doc: https://cert-manager.io/docs/
Source: https://github.com/SourceMation/charts.git

## Requirements

lack of informations

## Before Installation

1. Install chart via Apps: Cert-manager - Operator (1/2)

## After Installation

no action required

## Before Upgrade

no action required

## After Upgrade

no action required

## Tips and Tricks

lack of informations

## Known Issues

lack of informations


## CLI installation

### Preparation

```bash

export CHART_NAMESPACE=cert-manager
export CHART_VERSION=1.0.0

kubectl create ns ${CHART_NAMESPACE}

kubectl config set-context --current --namespace ${CHART_NAMESPACE}

```

### Go go helm

``` bash
#cat << EOF > /tmp/cert-manager-config-values.yaml
#EOF

helm -n ${CHART_NAMESPACE} upgrade --install cert-manager-config \
--repo https://sourcemation.github.io/charts/ \
cert-manager-config /
#-f /tmp/cert-manager-config-values.yaml /
--version ${CHART_VERSION}


kubectl -n ${CHART_NAMESPACE} get po

kubectl get issuers,clusterissuers,certificates,certificaterequests,orders,challenges -A

```


## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall cert-manager-config


```

