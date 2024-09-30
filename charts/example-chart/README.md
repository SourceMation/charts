## Generic

Based on: https://github.com/cert-manager/cert-manager.git
Doc: https://cert-manager.io/docs/
Source: https://github.com/SourceMation/charts.git


## Before Installation

1. Install following charts

```bash 

helm upgrade install ...

```
OR 

no action required

## After Installation

no action required

## Before Upgrade

no action required

## After Upgrade

no action required


## Known Issues


#### Error: Unable to continue with install: CustomResourceDefinition "*.cert-manager.io" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "": current value is ""

Reason: cert-manager is installed in another namespace

Soloution:

1. Do not deploy this operator

2. If do not have cert-manager, just clean resources

```bash 
kubectl get crd -o name | grep -i cert-manager | xargs kubectl delete

```


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
cat << EOF > /tmp/values.yaml

EOF 


helm -n ${CHART_NAMESPACE} upgrade --install example-chart \
--repo https://sourcemation.github.io/charts/ \
example-chart \
-f /tmp/values.yaml \
--version ${CHART_VERSION}

```

### Validation and Testing

```bash

kubectl -n ${CHART_NAMESPACE} get po

```

## CLI removing

```bash

helm -n ${CHART_NAMESPACE} uninstall cert-manager-operator

kubectl delete apiservice v1beta1.webhook.cert-manager.io

kubectl get crd -o name | grep -i cert-manager | xargs kubectl delete


```

