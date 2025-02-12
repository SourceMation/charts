## General

### Are you looking for more information?

1. Based on: https://github.com/coder/coder.git
2. Documentation: https://coder.com/docs
3. Chart Source: https://github.com/SourceMation/charts.git


## Before Installation

The installation of cert-manager is required according to the instructions provided in the README file of the latest version: https://github.com/SourceMation/charts/tree/main/charts/cert-manager

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
export CHART_NAME=coder
export CHART_VERSION=1.0.0
export CHART_NAMESPACE=coder-namespace
export CHART_URL=coder.apps.example.com
export CERT_ISSUER_NAME=default-selfsigned-ca
export CERT_ISSUER_KIND=ClusterIssuer
export CERT_SECRET_NAME=coder-tls-cert
```

```bash
kubectl create ns ${CHART_NAMESPACE}
kubectl config set-context --current --namespace ${CHART_NAMESPACE}
```

### Go go helm

``` bash
helm -n ${CHART_NAMESPACE} upgrade --install ${CHART_NAME} \
--set "coder.coder.ingress.host=${CHART_URL}" \
--set "coder.coder.ingress.tls.issuerName=${CERT_ISSUER_NAME}" \
--set "coder.coder.ingress.tls.issuerKind=${CERT_ISSUER_KIND}" \
--set "coder.coder.ingress.tls.secretName=${CERT_SECRET_NAME}"\
--repo https://sourcemation.github.io/charts/ ${CHART_NAME} \
--version ${CHART_VERSION}
```

### Validation and Testing

```bash
kubectl -n ${CHART_NAMESPACE} get po
```

## CLI removing

```bash
helm -n ${CHART_NAMESPACE} uninstall ${CHART_NAME}
kubectl -n ${CHART_NAMESPACE} delete $(kubectl get pvc -o name|grep -e '${CHART_NAME}')
```
