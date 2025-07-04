## General

### Are you looking for more information?

1. Based on: https://github.com/example-chart/example-chart.git
2. Documentation: https://example-app.io/docs/
3. Chart Source: https://github.com/SourceMation/charts.git


## Before Installation

> **Note:**
> no action required

OR

The installation of cert-manager is required according to the instructions
provided in the README file of the latest version:
https://github.com/SourceMation/charts/tree/main/charts/cert-manager

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

#### Error: Unable to continue with install: CustomResourceDefinition "*.example-chart.io" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "": current value is ""

Reason: example-chart is installed in another namespace

Soloution:

Skip the operator's deployment or if do not have example-manager installed, just clean resources

```bash 
kubectl get crd -o name | grep -i example-chart | xargs kubectl delete
```

## CLI installation

### Preparation

```bash
export RELEASE_NAME=example-app
export RELEASE_NAMESPACE=example-namespace
export CHART_NAME=example-chart
export CHART_VERSION=0.1.0


kubectl create ns ${RELEASE_NAMESPACE}
kubectl config set-context --current --namespace ${RELEASE_NAMESPACE}

cat << EOF > /tmp/values.yaml
example-app:
  ingress:
    host: 
    - url: app.example.com
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
helm -n ${RELEASE_NAMESPACE} test ${RELEASE_NAME}
```

## CLI removing

```bash
helm -n ${RELEASE_NAMESPACE} uninstall ${RELEASE_NAME}
```

## After remove

```bash
kubectl delete apiservice v1beta1.webhook.example-chart.io
kubectl get crd -o name | grep -i example-chart | xargs kubectl delete
```
